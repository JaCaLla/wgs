//
//  DataManager.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 28/01/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation

final class DataManager {

    // MARK: - Constants


    static let shared:DataManager = DataManager()

    // MARK: - Private attributes
    private static let indexFirstPage = 1
    private var personsListPage:Int = indexFirstPage

    // MARK: - Injected attributes
    private var injectedAPIManager:APIManager = APIManager()
    private var injectedDatabaseManager:DatabaseManager = DatabaseManager.shared

    init(apiManager:APIManager = APIManager(),
         databaseManager:DatabaseManager = DatabaseManager.shared) {
        
        self.injectedAPIManager = apiManager
        self.injectedDatabaseManager = databaseManager
    }

    // MARK:
    func getFirst(onSucceed : @escaping (([Person]) -> Void),
                  onFailed: @escaping ((ResponseCode) -> Void)) {
        self.personsListPage = DataManager.indexFirstPage
        //self.persons = []
        self.injectedDatabaseManager.removeAllPersons()
        injectedAPIManager.getPersons(page: self.personsListPage, onSucceed: { [weak self] npsRestResponse in
            guard let weakSelf = self else { return }
            weakSelf.personsListPage += 1
           // weakSelf.persons.append(contentsOf: npsRestResponse.results)
           // onSucceed(weakSelf.persons)
            weakSelf.injectedDatabaseManager.add(persons: npsRestResponse.results.map({ Person(personAPI: $0)}))
            onSucceed(weakSelf.injectedDatabaseManager.getPersons())
            }, onFailed: { responseCode in
                onFailed(responseCode)
        })
    }

    func getNext(onSucceed : @escaping (([Person]) -> Void),
                 onFailed: @escaping ((ResponseCode) -> Void)) {
        guard self.personsListPage > 0 else {
            self.getFirst(onSucceed: onSucceed, onFailed: onFailed)
            return
        }

        injectedAPIManager.getPersons(page: self.personsListPage, onSucceed: { [weak self] npsRestResponse in
            guard let weakSelf = self else { return }
            weakSelf.personsListPage += 1
           // weakSelf.persons.append(contentsOf: npsRestResponse.results)
            //onSucceed(weakSelf.persons)
            weakSelf.injectedDatabaseManager.add(persons: npsRestResponse.results.map({ Person(personAPI: $0)}))
            onSucceed(weakSelf.injectedDatabaseManager.getPersons())
            }, onFailed: { responseCode in
                onFailed(responseCode)
        })
    }


}

extension DataManager: Resetable {
    func reset() {
        self.injectedAPIManager = APIManager()
        self.injectedDatabaseManager.reset()
        self.personsListPage = DataManager.indexFirstPage
    }
}
