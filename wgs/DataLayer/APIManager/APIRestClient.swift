//
//  RestClient.swift
//  MVVMRedux
//
//

import Foundation
import Alamofire
import CocoaLumberjack
import CoreFoundation

protocol RestClientProtocol:class {

    func perform(request urlRequest: URLRequestConvertible,
                 success succeed : @escaping ((RestResponse) -> Void),
                 failure failed : @escaping ((ResponseCode) -> Void))

}

class APIRestClient: RestClientProtocol {

    static let shared:APIRestClient = APIRestClient()

    private init() { /*This prevents others from using the default '()' initializer for this class. */ }

    struct RestLog {
        static let startRequest = "\n� ↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️"
        static let endRequest = "\n↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️ �\n"
        static let startResponse = "\n� ✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅"
        static let endResponse = "\n✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅ �\n"
        static let startError = "\n� ❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
        static let endError = "\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌ �\n"
    }

    func perform(request urlRequest: URLRequestConvertible,
                 success succeed : @escaping ((RestResponse) -> Void),
                 failure failed : @escaping ((ResponseCode) -> Void)) {

        printHeaderRequest(urlRequest)
        Alamofire.request(urlRequest).validate(statusCode: 200..<401).responseJSON { [weak self] response in
            guard let weakSelf = self else { return }

            switch response.result {
            case .success:
                weakSelf.printHeaderResponse(response)
                weakSelf.processResponse(response: response,urlRequest: urlRequest,success: succeed,failure: failed)

            case .failure(let error):

                APIRestClient.printError(response: response)
                ((error as NSError).domain == NSURLErrorDomain) ? failed(ResponseCode.connectivityError) :
                    failed(ResponseCode.serverError)
            }
        }
    }

    // MARK: - Private methods
    fileprivate func processResponse( response: (DataResponse<Any>),
                                      urlRequest: URLRequestConvertible,
                                      success succeed : @escaping ((RestResponse) -> Void),
                                      failure failed : @escaping ((ResponseCode) -> Void)) {

        if let resultValue = response.result.value as? [String: AnyObject] {
            do {
            let jsonData = try JSONSerialization.data(withJSONObject: resultValue, options: [])
            let npsRestResponse = try JSONDecoder().decode(RestResponse.self, from: jsonData)
                succeed(npsRestResponse)
            } catch {
                failed(ResponseCode.badFormedJSONModel)
            }
        } else {
            failed(ResponseCode.missingResponseResultValue)
        }
    }

    fileprivate func printHeaderRequest(_ urlRequest: URLRequestConvertible) {
        DDLogInfo("\(RestLog.startRequest)")
        DDLogInfo("Starting Request...")
        if let method = urlRequest.urlRequest?.httpMethod {
            DDLogInfo("Method: \(String(describing: method))")

        }
        if let url = urlRequest.urlRequest?.url {
            DDLogInfo("URL: \(String(describing: url))")

        }
        if let headers = urlRequest.urlRequest?.allHTTPHeaderFields {
            DDLogInfo("Headers: \(String(describing: headers))")

        }
        if let body = urlRequest.urlRequest?.httpBody, let bodyUtf8 = String(data: body, encoding: .utf8) {
            DDLogInfo("Body: \(bodyUtf8)")

        }
        DDLogInfo("\(RestLog.endRequest)")
    }

    fileprivate func processSuccessResponseAferPerformingBuyRequest(_ response: (DataResponse<Any>),
                                                                    urlRequest: URLRequestConvertible,
                                                                    success succeed : @escaping ((Any) -> Void),
                                                                    failure failed : @escaping ((ResponseCode) -> Void)) {
        self.printHeaderResponse(response)
        if let resultValue = response.result.value as? [String:AnyObject] {
            succeed(resultValue as Any)
        } else {
            APIRestClient.printParsingErrorIn(request: urlRequest)
            failed(ResponseCode.badFormedJSONModel)
        }
    }

    // MARK: - Public Methods
    fileprivate func printHeaderResponse(_ response: (DataResponse<Any>)) {
        DDLogInfo("\(RestLog.startRequest)")
        DDLogInfo("Response:")
        DDLogInfo("\(response.debugDescription)")
        DDLogInfo("\(RestLog.endRequest)")
    }

    static func printError(response: DataResponse<Any>) {
        DDLogInfo("\(RestLog.startError)")
        DDLogError("Response:")
        DDLogError("\n\(response.debugDescription)")
        DDLogInfo("\(RestLog.endError)")
    }

    static func printParsingErrorIn(request: URLRequestConvertible) {
        DDLogInfo("\(RestLog.startError)")
        DDLogError("Response from request \(String(describing: request.urlRequest?.url?.debugDescription)) :")
        DDLogError("\nError parsing response")
        DDLogInfo("\(RestLog.endError)")
    }
}
