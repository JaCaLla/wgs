//
//  UTPerson.swift
//  wgsTests
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs
class UTPerson: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_constructor_fromPersonAPI() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let personAPI = PersonAPI(name: NameAPI(title: "1", first: "2", last: "3"),
                                  email: "b",
                                  picture: PictureAPI(thumbnail: "c"),
                                  location: LocationAPI(city: "d", coordinates: CoordinatesAPI(latitude: "e", longitude: "f")))

        let person = Person(personAPI:personAPI)
        XCTAssertEqual(person.first, "2")
        XCTAssertEqual(person.email, "b")
        XCTAssertEqual(person.latitude, "e")
        XCTAssertEqual(person.longitude, "f")
        XCTAssertEqual(person.thumbnail, "c")
    }


}
