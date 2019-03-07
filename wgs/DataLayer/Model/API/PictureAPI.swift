//
//  Park.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

struct PictureAPI {

    struct  JSONAttributeKey {
        static let thumbnail = "thumbnail"
    }

    // MARK: - Public attributes
    var thumbnail:String = ""
}

extension PictureAPI:Decodable {
    enum PictureKeys: String, CodingKey {
        case thumbnail = "thumbnail"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: PictureKeys.self)
        let thumbnail = try container.decode(String.self, forKey: .thumbnail)

        self.init(thumbnail: thumbnail)
    }
}

