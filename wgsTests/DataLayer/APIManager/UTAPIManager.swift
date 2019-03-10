//
//  UTAPIManager.swift
//  MVVMReduxTests
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs

class UTAPIManager: XCTestCase {

    let timeout:Double = 10.0

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Router
    func testAttributes() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(APIManager.APIRouter.host, "api.randomuser.me")
        XCTAssertEqual(APIManager.APIRouter.scheme, "https")
        XCTAssertEqual(APIManager.APIRouter.baseURLString, "https://api.randomuser.me")
        XCTAssertEqual(APIManager.APIRouter.version, "v1")
    }

    func testGetPersonsUrl() {

        let getPersons = APIManager.APIRouter.getPersons
        XCTAssertEqual(getPersons(0).method, .get)
        XCTAssertEqual(getPersons(0).path, "/")
        XCTAssertEqual(getPersons(0).resolveURLRequest().httpMethod ?? "", "GET")

        XCTAssertEqual(getPersons(0).resolveURLRequest().url?.absoluteString,
                       "https://api.randomuser.me/?results=10&page=0&seed=xmoba")

    }

    // MARK: - API Services  (Get Persons)

    func testGetPersons_ServerFailed() {
        let asyncExpectation = expectation(description: "\(#function)")

        MockAPIRestClient.shared.responseCode = ResponseCode.serverError

        APIManager(restClient:MockAPIRestClient.shared).getPersons(page: 0, onSucceed: { npsRestResponse in
            XCTFail()
            asyncExpectation.fulfill()
        }, onFailed: { responseCode in

            XCTAssertEqual(responseCode, ResponseCode.serverError)
            asyncExpectation.fulfill()
        })

        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }

    func testGetPersonsWrongUrl() {
        let asyncExpectation = expectation(description: "\(#function)")

        MockAPIManagerWrongUrl(restClient:MockAPIRestClient.shared).getPersons(page: 0, onSucceed: { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }, onFailed: { responseCode in

            XCTAssertEqual(responseCode, ResponseCode.serverError)
            asyncExpectation.fulfill()
        })

        self.waitForExpectations(timeout: self.timeout, handler: nil)

    }

    func testGetPersons_Page1() {
        let asyncExpectation = expectation(description: "\(#function)")

        APIManager().getPersons(page: 1, onSucceed: { restResponse in

            guard restResponse.results.count ==  10 else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }

            XCTAssertEqual(restResponse.results[0].email, "christian.pedersen@example.com")
            XCTAssertEqual(restResponse.results[0].location.city, "viby sj.")
            XCTAssertEqual(restResponse.results[0].name.title, "mr")
            XCTAssertEqual(restResponse.results[0].name.first, "christian")
            XCTAssertEqual(restResponse.results[0].name.last, "pedersen")
            XCTAssertEqual(restResponse.results[0].location.coordinates.latitude, "-30.8785")
            XCTAssertEqual(restResponse.results[0].location.coordinates.longitude, "-76.7378")
            XCTAssertEqual(restResponse.results[0].picture.thumbnail, "https://randomuser.me/api/portraits/thumb/men/8.jpg")
            XCTAssertEqual(restResponse.results[0].picture.large, "https://randomuser.me/api/portraits/men/8.jpg")

            asyncExpectation.fulfill()
        }, onFailed: { _ in
            XCTFail()
            asyncExpectation.fulfill()
        })

        self.waitForExpectations(timeout: self.timeout, handler: nil)

    }

    func testGetPersons_Page2() {
        let asyncExpectation = expectation(description: "\(#function)")

        APIManager().getPersons(page: 2, onSucceed: { restResponse in

            guard restResponse.results.count ==  10 else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }

            XCTAssertEqual(restResponse.results[0].email, "salma.dacruz@example.com")
            XCTAssertEqual(restResponse.results[0].location.city, "francisco morato")
            XCTAssertEqual(restResponse.results[0].name.title, "mr")
            XCTAssertEqual(restResponse.results[0].name.first, "salma")
            XCTAssertEqual(restResponse.results[0].name.last, "da cruz")
            XCTAssertEqual(restResponse.results[0].location.coordinates.latitude, "-69.3963")
            XCTAssertEqual(restResponse.results[0].location.coordinates.longitude, "-54.5418")
            XCTAssertEqual(restResponse.results[0].picture.thumbnail, "https://randomuser.me/api/portraits/thumb/men/25.jpg")
            XCTAssertEqual(restResponse.results[0].picture.large, "https://randomuser.me/api/portraits/men/25.jpg")

            asyncExpectation.fulfill()
        }, onFailed: { _ in
            XCTFail()
            asyncExpectation.fulfill()
        })

        self.waitForExpectations(timeout: self.timeout, handler: nil)

    }

}
