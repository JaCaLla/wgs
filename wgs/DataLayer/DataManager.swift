//
//  DataManager.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 28/01/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

final class DataManager {

    // MARK: - Constants
    struct NotificationId {
        static let deletedPerson = "DataManager.deletedPerson"
        static let updatedPerson = "DataManager.updatedPerson"
    }

    static let shared:DataManager = DataManager()

    // MARK: - Private attributes

    // MARK: - Injected attributes
    private var injectedAPIManager:APIManager = APIManager()
    private var injectedDatabaseManager:DatabaseManager = DatabaseManager.shared
    private var injectedLocalFileManager:LocalFileManager = LocalFileManager.shared
    private var injectedConfigurationManager:ConfigurationManager = ConfigurationManager.shared

    init(apiManager:APIManager = APIManager(),
         databaseManager:DatabaseManager = DatabaseManager.shared,
         localFileManager:LocalFileManager = LocalFileManager.shared,
        configurationManager: ConfigurationManager = ConfigurationManager.shared) {
        
        self.injectedAPIManager = apiManager
        self.injectedDatabaseManager = databaseManager
        self.injectedLocalFileManager = localFileManager
        self.injectedConfigurationManager = configurationManager
    }

    // MARK: - API
    func getFirst(onSucceed : @escaping (([Person]) -> Void),
                  onFailed: @escaping ((ResponseCode) -> Void)) {
        let lastPersistedPage = injectedConfigurationManager.getLastPersistedPage() ?? 0

        guard lastPersistedPage == 0 else {
            onSucceed(injectedDatabaseManager.getPersons())
            return
        }
        self.injectedDatabaseManager.removeAllPersons()
        injectedAPIManager.getPersons(page: 1, onSucceed: { [weak self] people in
            guard let weakSelf = self else { return }
            weakSelf.injectedConfigurationManager.set(lastPersistedPage: 1)
            weakSelf.injectedDatabaseManager.add(persons: people.results.map({ Person(personAPI: $0)}))
            onSucceed(weakSelf.injectedDatabaseManager.getPersons())
            }, onFailed: { responseCode in
                onFailed(responseCode)
        })
    }

    func getNext(onSucceed : @escaping (([Person]) -> Void),
                 onFailed: @escaping ((ResponseCode) -> Void)) {

         var lastPersistedPage = injectedConfigurationManager.getLastPersistedPage() ?? 0
        guard lastPersistedPage > 0 else {
            self.getFirst(onSucceed: onSucceed, onFailed: onFailed)
            return
        }
        lastPersistedPage += 1
        injectedAPIManager.getPersons(page: lastPersistedPage, onSucceed: { [weak self] npsRestResponse in
            guard let weakSelf = self else { return }
            weakSelf.injectedConfigurationManager.set(lastPersistedPage:lastPersistedPage)
            weakSelf.injectedDatabaseManager.add(persons: npsRestResponse.results.map({ Person(personAPI: $0)}))
            onSucceed(weakSelf.injectedDatabaseManager.getPersons())
            }, onFailed: { responseCode in
                onFailed(responseCode)
        })
    }

    // MARK: - Database Manager
    func getFetched(onComplete : @escaping (([Person]) -> Void)) {
        onComplete(injectedDatabaseManager.getPersons())
    }

    func remove(person:Person, onComplete: () -> Void = {/* Default empty block*/}) {
    
       injectedDatabaseManager.remove(person: person)
        injectedLocalFileManager.remove(filename: person.getImageName() ?? "")

        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: NSNotification.Name(rawValue: DataManager.NotificationId.deletedPerson),
                                object: nil)
       onComplete()
    }

    func update(oldPerson:Person,newPerson:Person, onComplete: (Person) -> Void = { _ in /* Default empty block*/}) {
        injectedDatabaseManager.update(oldPerson: oldPerson, newPerson: newPerson)

        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: NSNotification.Name(rawValue: DataManager.NotificationId.updatedPerson),
                                object: nil)
        onComplete(newPerson)

    }

    // MARK: - LocalFileManager
    func save(imageName: String, image: UIImage) {
        injectedLocalFileManager.saveImage(imageName: imageName, image: image)
    }

    func getImage(fileName: String) -> UIImage? {
        return injectedLocalFileManager.loadImage(fileName:fileName)
    }

    // MARK: - Configuration Manager
    func set(lastPersistedPage:Int) {

         ConfigurationManager.shared.set(lastPersistedPage: lastPersistedPage)
    }

    func getLastPersistedPage() -> Int? {
        return ConfigurationManager.shared.getLastPersistedPage()
    }
}

extension DataManager: Resetable {
    func reset() {
        self.injectedAPIManager = APIManager()
        self.injectedDatabaseManager.reset()
        self.injectedLocalFileManager.reset()
        self.injectedConfigurationManager.reset()
    }
}
