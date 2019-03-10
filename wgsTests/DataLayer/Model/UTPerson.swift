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
        DataManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_constructor_fromPersonAPI() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let personAPI = PersonAPI(name: NameAPI(title: "1", first: "2", last: "3"),
                                  email: "b",
                                  picture: PictureAPI(thumbnail: "c",large:"h"),
                                  location: LocationAPI(city: "d", coordinates: CoordinatesAPI(latitude: "e", longitude: "f")))

        let person = Person(personAPI:personAPI)
        XCTAssertEqual(person.first, "2")
        XCTAssertEqual(person.email, "b")
        XCTAssertEqual(person.latitude, "e")
        XCTAssertEqual(person.longitude, "f")
        XCTAssertEqual(person.thumbnail, "c")
        XCTAssertEqual(person.large, "h")
    }

    func test_constructor_fromPerson_withImage() {
        var person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e" , large:"f",image: nil)
        person1.set(image: R.image.default_profile()!)
        let person2 = Person(email: person1.email,
                             first: person1.first,
                             latitude: person1.latitude,
                             longitude: person1.longitude,
                             thumbnail: person1.thumbnail,
                             large: person1.large,
                             image: person1.getImage())

        XCTAssertEqual(person2.first, "b")
        XCTAssertEqual(person2.email, "a")
        XCTAssertEqual(person2.latitude, "c")
        XCTAssertEqual(person2.longitude, "d")
        XCTAssertEqual(person2.thumbnail, "e")
        XCTAssertEqual(person2.large, "f")
        XCTAssertNotNil(person2.getImage())
        XCTAssertNotEqual(person1.getImageName()!, person2.getImageName()!)
        XCTAssertNotEqual(person1,person2)
        XCTAssertEqual(LocalFileManager.shared.count(), 2)
    }

    func test_constructor_fromPerson_withoutImage() {
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e" , large: "f", image: nil)
        let person2 = Person(email: person1.email,
                             first: person1.first,
                             latitude: person1.latitude,
                             longitude: person1.longitude,
                             thumbnail: person1.thumbnail,
                             large: person1.large,
                             image: person1.getImage())

        XCTAssertNil(person1.getImage())

        XCTAssertEqual(person2.first, "b")
        XCTAssertEqual(person2.email, "a")
        XCTAssertEqual(person2.latitude, "c")
        XCTAssertEqual(person2.longitude, "d")
        XCTAssertEqual(person2.thumbnail, "e")
        XCTAssertEqual(person2.large, "f")
        XCTAssertNil(person2.getImage())
          XCTAssertEqual(person1,person2)
    }


}
