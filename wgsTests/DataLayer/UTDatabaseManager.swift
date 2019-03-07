//
//  UTDatabaseManager.swift
//  wgsTests
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs
class UTDatabaseManager: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_addPersons() {
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e")
        DatabaseManager.shared.add(persons: [person1])
         XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.add(persons: [person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)

        DataManager.shared.reset()

        let person3 = Person(email: "x", first: "y", latitude: "z", longitude: "u", thumbnail: "w")
        DatabaseManager.shared.add(persons: [person3])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

    }

    func test_addPersonsEqual() {
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e")
        DatabaseManager.shared.add(persons: [person1])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.add(persons: [person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)

        // person 3 is same as person1
        let person3 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.add(persons: [person3])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)
    }

    func test_removePerson() {

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e")
        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.add(persons: [person1,person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)

        // Remove a person that exists
        let person3 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.remove(person: person3)
         XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        // Remove a person that does not exists
        let person4 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.remove(person: person4)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        // Remove a person that exists
        let person5 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e")
        DatabaseManager.shared.remove(person: person5)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
    }

    func test_removeAll() {
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e")
        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.add(persons: [person1,person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)
        DatabaseManager.shared.removeAllPersons()
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
    }

    func test_updatePerson() {

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e")
        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5")
        DatabaseManager.shared.add(persons: [person1,person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)

        // Remove a person that exists
        let person3 = Person(email: "1+", first: "2+", latitude: "3+", longitude: "4+", thumbnail: "5+")
        DatabaseManager.shared.update(oldPerson: person2, newPerson: person3)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].email, "a")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].first, "b")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].latitude, "c")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].longitude, "d")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].thumbnail, "e")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].email, "1+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].first, "2+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].latitude, "3+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].longitude, "4+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].thumbnail, "5+")

        // Remove a person that does not exists
        DatabaseManager.shared.update(oldPerson: person2, newPerson: person3)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].email, "a")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].first, "b")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].latitude, "c")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].longitude, "d")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[0].thumbnail, "e")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].email, "1+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].first, "2+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].latitude, "3+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].longitude, "4+")
        XCTAssertEqual(DatabaseManager.shared.getPersons()[1].thumbnail, "5+")



    }


}
