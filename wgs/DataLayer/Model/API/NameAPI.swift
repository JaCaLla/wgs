//
//  Park.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

struct NameAPI {

    struct  JSONAttributeKey {
        static let title = "title"
        static let first = "first"
        static let last = "last"
    }

    // MARK: - Public attributes
    var title:String = ""
    var first:String = ""
    var last:String = ""
}

extension NameAPI:Decodable {
    enum NameKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: NameKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let first  = try container.decode(String.self, forKey: .first)
        let last = try container.decode(String.self, forKey: .last)

        self.init(title: title, first: first, last:last)
    }
}

