//
//  RestResponse.swift
//  MVVMRedux
//
//

import Foundation

struct RestResponseKey {
    static let success = "success"
    static let result = "result"
}

enum ResponseCode : Int {
    case missingResponseResultValue = -5
    case badFormedJSONModel = -3
    case unhandledError = -2
    case serverError = -1
    case connectivityError = -4
    case success = 0
    case invalidSDKRecipeNumber = 10000
    case accountDoesNotExist = 10004
    case accountAlreadyExist = 10003
    case chatExists = 150000
    case userBlocked = 150001
}

struct RestResponse {
    //var total:Int = -1
    //var limit:Int = -1
    //var start:Int = -1
    var results:[PersonAPI] = []
}

extension RestResponse:Decodable {
    enum MyStructKeys: String, CodingKey {
       // case total = "total"
       // case limit = "limit"
       // case start = "start"
        case results = "results"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
       // let total = try container.decode(Int.self, forKey: .total)
       // let limit = try container.decode(Int.self, forKey: .limit)
       // let start = try container.decode(Int.self, forKey: .start)
        let results = try container.decode([PersonAPI].self, forKey: .results)

        self.init(results:results)
    }
}
