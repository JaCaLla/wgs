//
//  MockNPSAPIRestClient.swift
//  MVVMReduxTests
//
//  Created by 08APO0516 on 04/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import Alamofire
import CocoaLumberjack
import CoreFoundation

@testable import wgs

class MockAPIRestClient: RestClientProtocol {

    static let shared:MockAPIRestClient = MockAPIRestClient()

    // MARK: - Public attributes
    var responseCode:ResponseCode = ResponseCode.serverError

    private init() { /*This prevents others from using the default '()' initializer for this class. */ }

    func perform(request urlRequest: URLRequestConvertible, success succeed: @escaping ((RestResponse) -> Void), failure failed: @escaping ((ResponseCode) -> Void)) {
        failed(ResponseCode.serverError)
    }
}
