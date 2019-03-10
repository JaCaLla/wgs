//
//  UTPeopleUseCase.swift
//  wgsTests
//
//  Created by 08APO0516 on 09/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs
class UTPeopleUseCase: XCTestCase {

    let timeout:Double = 5.0

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getFirst_WhenExistsPersistedData() {

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)
        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5",large:"6" ,image: nil)
        DatabaseManager.shared.add(persons: [person1,person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)

        ConfigurationManager.shared.set(lastPersistedPage: 2)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 2)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

    func test_getNext_WhenExistsPersistedData() {

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)
        let person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5",large:"6" ,image: nil)
        DatabaseManager.shared.add(persons: [person1,person2])
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 2)

        ConfigurationManager.shared.set(lastPersistedPage: 1)

        DataManager.shared.getNext(onSucceed: { persons in
            XCTAssertEqual(persons.count, 12)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 12)
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

}
