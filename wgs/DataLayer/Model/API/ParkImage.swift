//
//  ParkImage.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 05/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation

struct ParkImage {

    struct  JSONAttributeKey {
        static let credit = "credit"
        static let title = "title"
        static let url = "url"
    }

    // MARK: - Public attributes
    var credit:String = ""
    var title:String = ""
    var url:String = ""
}

extension ParkImage:Decodable {
    enum ParkImageKeys: String, CodingKey {
        case credit = "credit"
        case title = "title"
        case url = "url"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: ParkImageKeys.self)
        let credit = try container.decode(String.self, forKey: .credit)
        let title = try container.decode(String.self, forKey: .title)
        let url = try container.decode(String.self, forKey: .url)

        self.init(credit: credit, title: title, url: url)
    }
}
/*
extension ParkImage: JSONDecodable {
    init?(dictionary: JSONDictionary?) {
        guard let jsonDictionary = dictionary,
            let uwpCredit = jsonDictionary[JSONAttributeKey.credit] as? String,
            let uwpTitle = jsonDictionary[JSONAttributeKey.title] as? String,
            let uwpUrl = jsonDictionary[JSONAttributeKey.url] as? String else {
                return nil
        }

        self.credit = uwpCredit
        self.title = uwpTitle
        self.url = uwpUrl
    }
}
*/
