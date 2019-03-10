//
//  UTPeopleListViewModelState.swift
//  wgsTests
//
//  Created by 08APO0516 on 10/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs
class UTPeopleListViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegularStateFlow() {
        let asyncExpectation = expectation(description: "\(#function)")

        var expectedViewModelState:PeopleListViewModelState = .fetching
        let viewModel = PeopleListViewModel()
        viewModel.onStateChanged = { newViewModelState in
            if newViewModelState.rawValue == PeopleListViewModelState.fetching.rawValue,
                expectedViewModelState.rawValue == newViewModelState.rawValue {
                expectedViewModelState = .fetched([])
            }  else if newViewModelState.rawValue == PeopleListViewModelState.fetched([]).rawValue,
                expectedViewModelState.rawValue == newViewModelState.rawValue {

                switch  newViewModelState {
                case .fetched (let people): XCTAssertEqual(people.count, 10)
                default: XCTFail()
                }
                asyncExpectation.fulfill()
            }
        }

        viewModel.fetch()
        self.waitForExpectations(timeout: 10, handler: nil)
    }


}
