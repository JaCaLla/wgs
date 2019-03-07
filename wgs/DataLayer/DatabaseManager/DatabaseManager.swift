//
//  DatabaseManager.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
class DatabaseManager {

     static let shared:DatabaseManager = DatabaseManager()

    // MARK: - Private attributes
    private var persons:[Person] = []

    private init() { /* Default empty block*/  }

    // MARK : - Public helpers
    func add(persons:[Person]) {
        var tmpPersons:[Person] = Array(persons)
        guard let firstPerson = tmpPersons.first else {
            return
        }
        self.add(person: firstPerson)
        tmpPersons.removeFirst()
        self.add(persons:tmpPersons)
    }

    func add(person:Person) {
        guard persons.firstIndex(of: person) == nil else {
            return
        }
        self.persons.append(person)
    }

    func getPersons() -> [Person] {
        return self.persons
    }

    func remove(person:Person) {
        guard let index = persons.firstIndex(of: person) else {
            return
        }
         self.persons.remove(at: index)
    }

    func update(oldPerson:Person,newPerson:Person) {
        if let index = persons.index(where: {$0 == oldPerson }) {
             self.persons[index] = newPerson
        }
    }

    func removeAllPersons() {
        self.persons = []
    }
}

extension DatabaseManager: Resetable {
    func reset() {
        self.persons = []
    }
}

