//
//  UTLocalFileManager.swift
//  wgsTests
//
//  Created by 08APO0516 on 08/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs
class UTLocalFileManager: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        LocalFileManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_saveAndRetrieveImage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let image = R.image.default_profile() else {XCTFail(); return}

        // Look out!!!!
        // During storage images is processed to reduce its weight, so it is necessary store 
        LocalFileManager.shared.saveImage(imageName: "patata", image: image)
        XCTAssertNotNil(LocalFileManager.shared.loadImageFromDiskWith(fileName: "patata"))

        LocalFileManager.shared.reset()
         XCTAssertNil(LocalFileManager.shared.loadImageFromDiskWith(fileName: "patata"))
    }

    func test_removeImage() {
        guard let image = R.image.default_profile() else {XCTFail(); return}

        // Look out!!!!
        // During storage images is processed to reduce its weight, so it is necessary store
        LocalFileManager.shared.saveImage(imageName: "patata", image: image)
         XCTAssertNotNil(LocalFileManager.shared.loadImageFromDiskWith(fileName: "patata"))

        LocalFileManager.shared.remove(filename: "patata")
         XCTAssertNil(LocalFileManager.shared.loadImageFromDiskWith(fileName: "patata"))
    }

}
