//
//  UTConfigurationManager.swift
//  wgsTests
//
//  Created by 08APO0516 on 08/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs

class UTConfigurationManager: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ConfigurationManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // MARK: - lastPersistedPage
    func test_lastPersistedPage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNil(ConfigurationManager.shared.getLastPersistedPage())
        ConfigurationManager.shared.set(lastPersistedPage:22)
        XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),22)
        ConfigurationManager.shared.set(lastPersistedPage:5)
        XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),5)

        ConfigurationManager.shared.reset()
        XCTAssertNil(ConfigurationManager.shared.getLastPersistedPage())
        ConfigurationManager.shared.set(lastPersistedPage:8)
        XCTAssertEqual(ConfigurationManager.shared.getLastPersistedPage(),8)
    }
}
