//
//  MockNPSAPIRestClientWrongUrl.swift
//  MVVMReduxTests
//
//  Created by 08APO0516 on 05/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

@testable import wgs

import Foundation
import Alamofire

class MockAPIManagerWrongUrl {
    
    // MARK: - Router
    enum APIRouter: URLRequestConvertible {
        case getPersons

        static let host = "api.randomuser.meXXXXXX" // <--- Wrong URL!!!
        static let scheme = "https"
        static let baseURLString =  scheme + "://" + host

        var method: Alamofire.HTTPMethod {
            switch self {
            case .getPersons:    return .get
            }
        }

        static func versionNumber() -> Int { return  1 }
        static var version: String {
            return "v\(APIRouter.versionNumber())"
        }

        var path: String {
            switch self {
            case .getPersons: return "/"
            }
        }

        func resolveURLRequest() -> URLRequest {

            guard let url = URL(string: APIRouter.baseURLString) else {
                return URLRequest(url: URL(fileURLWithPath: ""))
            }

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            switch self {
            case .getPersons: return buildURLRequest()
            }
        }

        fileprivate func buildURLRequest() -> URLRequest {
            var urlComponents = URLComponents()
            urlComponents.scheme = APIRouter.scheme
            urlComponents.host = APIRouter.host
            urlComponents.path = path
            urlComponents.queryItems = [URLQueryItem(name: "results", value: "100"),
                                        URLQueryItem(name: "seed", value: "xmoba")]

            var urlRequest = URLRequest(url: urlComponents.url  ?? URL(fileURLWithPath: ""))

            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }

        func asURLRequest() throws -> URLRequest {

            switch self {
            case .getPersons:
                let urlRequest = resolveURLRequest()
                return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
            }
        }
    }

    var injectedRestClient:RestClientProtocol = APIRestClient.shared

    init(restClient:RestClientProtocol = APIRestClient.shared) {
        self.injectedRestClient = restClient
    }

    // MARK: - Service helpers
    func getPersons(page: Int,
                    onSucceed: @escaping ((RestResponse) -> Void),
                    onFailed: @escaping ((ResponseCode) -> Void)) {

        self.injectedRestClient.perform(request: APIRouter.getPersons,
                                        success: { response in
                                            onSucceed(response)
        }, failure: { responseCode in
            onFailed(responseCode)
        })
    }

}
