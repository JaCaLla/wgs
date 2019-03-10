//
//  DatabaseManager.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import CocoaLumberjack
import RealmSwift

extension Realm {

    /// Performs actions contained within the given block
    /// inside a write transaction with completion block.
    ///
    /// - parameter block: write transaction block
    /// - parameter completion: completion executed after transaction block
    func write(transaction block: @escaping () -> Void, completion: () -> Void) throws {
        try write(block )
        completion()
    }
}

class DatabaseManager {

    static let shared:DatabaseManager = DatabaseManager()

    // MARK: - Private attributes
    private var thread = Thread.current
    private var realm:Realm!

    private init() {
        setRealmHandlers()
    }

    // MARK : - Public helpers
    func add(persons:[Person]) {
        var tmpPersons:[Person] = Array(persons)
        guard let firstPerson = tmpPersons.first else {
            return
        }
        self.add(person: firstPerson, onComplete: { [weak self] in
            guard let weakSelf = self else { return }
            tmpPersons.removeFirst()
            weakSelf.add(persons:tmpPersons)
        })

    }

    func add(person:Person,onComplete: (() -> Void) = { /* Empty block as default */ }) {

        self.resetHandlerIfNecessary()
        guard !self.exists(person: person) else {
            onComplete()
            return
        }

        do {
            try realm.write(transaction: {
                self.realm.add(PersonEntity(person: person))
            }, completion: {
                onComplete()
            })
        } catch {
            DDLogError("ERROR: Adding person in Database")
        }
    }

    func exists(person:Person) -> Bool {

        self.resetHandlerIfNecessary()
        let personEntity:PersonEntity = PersonEntity(person: person)

        return  realm.objects(PersonEntity.self).filter("email == %@ AND firstName == %@ AND latitude == %@ AND longitude == %@ AND thumbnail == %@ AND large == %@",
                                                        personEntity.email,
                                                        personEntity.firstName,
                                                        personEntity.latitude,
                                                        personEntity.longitude,
                                                        personEntity.thumbnail,
                                                        personEntity.large).first != nil
    }

    func get(person:Person) -> PersonEntity? {

        self.resetHandlerIfNecessary()
        let personEntity:PersonEntity = PersonEntity(person: person)

        return  realm.objects(PersonEntity.self).filter("email == %@ AND firstName == %@ AND latitude == %@ AND longitude == %@ AND thumbnail == %@ and large == %@",
                                                        personEntity.email,
                                                        personEntity.firstName,
                                                        personEntity.latitude,
                                                        personEntity.longitude,
                                                        personEntity.thumbnail,
                                                        personEntity.large).first
    }

    func getPersons() -> [Person] {

        self.resetHandlerIfNecessary()

        let personEntities = realm.objects(PersonEntity.self).sorted(byKeyPath: "creation", ascending: true)
        return personEntities.map({ Person(personEntity: $0) })
    }

    func remove(person:Person, onComplete: (() -> Void) = { /* Empty block as default */ }) {

        self.resetHandlerIfNecessary()
        guard let personEntity = self.get(person: person) else {
            onComplete()
            return
        }

        do {
            try realm.write(transaction: {
                self.realm.delete(personEntity)
            }, completion: {
                onComplete()
            })
        } catch {
            DDLogError("ERROR: Removing person in Database")
        }
    }

    func update(oldPerson:Person,newPerson:Person, onComplete: (() -> Void) = { /* Empty block as default */ }) {

        self.resetHandlerIfNecessary()
        guard let personEntity = self.get(person: oldPerson) else {
            onComplete()
            return
        }

        do {
            try realm.write(transaction: {
                personEntity.email              = newPerson.email
                personEntity.firstName          = newPerson.first
                personEntity.thumbnail          = newPerson.thumbnail
                personEntity.latitude           = newPerson.latitude
                personEntity.longitude          = newPerson.longitude
                personEntity.large              = newPerson.large
                personEntity.imageLocalName     = newPerson.getImageName()
            }, completion: {
                onComplete()
            })
        } catch {
           DDLogError("ERROR: Updating person in Database")
        }
    }

    func removeAllPersons(onComplete: (() -> Void) = { /* Empty block as default */ }) {

        self.resetHandlerIfNecessary()

        do {
            let allPersonEntity = realm.objects(PersonEntity.self)
            try realm.write(transaction: {
                self.realm.delete(allPersonEntity)
            }, completion: {
                onComplete()
            })
        } catch {
           DDLogError("ERROR: Removing all people in Database")
        }
    }

    // MARK: - Private/Internal
    private func resetHandlerIfNecessary() {
        guard thread == Thread.current else {
            self.setRealmHandlers()
            thread = Thread.current
            return
        }
    }

    private func setRealmHandlers() {
        do {
            if NSClassFromString("XCTest") != nil {
                realm = try Realm(configuration: RealmConfig.utest.configuration)
            } else {
                realm = try Realm(configuration: RealmConfig.main.configuration)
            }
        } catch {
            DDLogError("ERROR: Setting Realm handlerse")
        }
    }
}

extension DatabaseManager: Resetable {
    func reset() {

        self.resetHandlerIfNecessary()

        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
           DDLogError("ERROR: Reseting whole Database")
        }
    }
}

