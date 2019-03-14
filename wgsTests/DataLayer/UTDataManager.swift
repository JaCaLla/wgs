//
//  UTDataManager.swift
//  wgsTests
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs

class UTDataManager: XCTestCase {

    let timeout:Double = 5.0 * 100.0

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getFirst() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")
        
         DataManager.shared.reset()

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
             XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout + 99999 , handler: nil)
    }

    func test_getFirstFirst() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            DataManager.shared.getFirst(onSucceed: { persons in
                XCTAssertEqual(persons.count, 10)
                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
                asyncExpectation.fulfill()
            }) { _ in
                XCTFail()
                asyncExpectation.fulfill()
            }
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

    func test_getFirstNext() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            DataManager.shared.getNext(onSucceed: { persons in
                XCTAssertEqual(persons.count, 20)
                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 20)
                asyncExpectation.fulfill()
            }) { _ in
                XCTFail()
                asyncExpectation.fulfill()
            }
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout + 9999, handler: nil)
    }

    func test_getFirstNextNext() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")
         DataManager.shared.reset()

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            DataManager.shared.getNext(onSucceed: { persons in
                XCTAssertEqual(persons.count, 20)
                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 20)
                DataManager.shared.getNext(onSucceed: { persons in
                    XCTAssertEqual(persons.count, 30)
                    XCTAssertEqual(DatabaseManager.shared.getPersons().count, 30)
                    asyncExpectation.fulfill()
                }) { _ in
                    XCTFail()
                    asyncExpectation.fulfill()
                }
            }) { _ in
                XCTFail()
                asyncExpectation.fulfill()
            }
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout , handler: nil)
    }

    func test_getFirstNextNextFirst() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")
        XCTAssertNil(ConfigurationManager.shared.getLastPersistedPage())
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),1)
            DataManager.shared.getNext(onSucceed: { persons in
                XCTAssertEqual(persons.count, 20)
                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 20)
                XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),2)
                DataManager.shared.getNext(onSucceed: { persons in
                    XCTAssertEqual(persons.count, 30)
                    XCTAssertEqual(DatabaseManager.shared.getPersons().count, 30)
                    XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),3)
                    DataManager.shared.getFirst(onSucceed: { persons in
                        XCTAssertEqual(persons.count, 30)
                        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 30)
                        XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),3)
                        asyncExpectation.fulfill()
                    }) { _ in
                        XCTFail()
                        asyncExpectation.fulfill()
                    }
                }) { _ in
                    XCTFail()
                    asyncExpectation.fulfill()
                }
            }) { _ in
                XCTFail()
                asyncExpectation.fulfill()
            }
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

    // MARK: - DatabaseManager
    func test_addPersons() {
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e" ,large: "f",image: nil)
        var person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5", large: "6", image: nil)
        person2.set(image: R.image.default_profile()!)


        DataManager.shared.update(oldPerson: person1, newPerson: person2)
        let asyncExpectation = expectation(description: "\(#function)")
        DataManager.shared.update(oldPerson: person1, newPerson: person2, onComplete: { updatedPerson in
            XCTAssertNotNil(updatedPerson.getImage())
            LocalFileManager.shared.reset()
            XCTAssertNil(updatedPerson.getImage())

             asyncExpectation.fulfill()
        })
         self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

    func test_removePerson_WithoutImage() {
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e" ,large: "f",image: nil)

        let asyncExpectation = expectation(description: "\(#function)")

        DatabaseManager.shared.add(person: person1, onComplete: {
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)
            DatabaseManager.shared.remove(person: person1, onComplete: {
                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
                XCTAssertEqual(LocalFileManager.shared.count(), 0)
                asyncExpectation.fulfill()
            })
        })

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

    func test_removePerson_WithImage() {
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e" ,large: "f",image: nil)
        var person2 = Person(email: "1", first: "2", latitude: "3", longitude: "4", thumbnail: "5", large: "6", image: nil)
        person2.set(image: R.image.default_profile()!)

        DataManager.shared.update(oldPerson: person1, newPerson: person2)
        XCTAssertEqual(LocalFileManager.shared.count(), 1)

        let asyncExpectation = expectation(description: "\(#function)")

            DataManager.shared.remove(person: person1, onComplete: {
                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
                XCTAssertEqual(LocalFileManager.shared.count(), 0)
                asyncExpectation.fulfill()
            })

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }



    func test_fetchAPI_WhenDBHasData() {


        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
            XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),1)


            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

}
