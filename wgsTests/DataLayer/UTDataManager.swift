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

    let timeout:Double = 5.0

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

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)

        DataManager.shared.getFirst(onSucceed: { persons in
            XCTAssertEqual(persons.count, 10)
             XCTAssertEqual(DatabaseManager.shared.getPersons().count, 10)
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: self.timeout, handler: nil)
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

    

}
