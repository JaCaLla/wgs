//
//  Park.swift
//  wgs
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

struct PictureAPI {

    struct  JSONAttributeKey {
        static let thumbnail = "thumbnail"
        static let large = "large"
    }

    // MARK: - Public attributes
    var thumbnail:String    = ""
    var large:String        = ""
}

extension PictureAPI:Decodable {
    enum PictureKeys: String, CodingKey {
        case thumbnail  = "thumbnail"
        case large      = "large"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: PictureKeys.self)
        let thumbnail = try container.decode(String.self, forKey: .thumbnail)
        let large = try container.decode(String.self, forKey: .large)

        self.init(thumbnail: thumbnail, large:large)
    }
}

