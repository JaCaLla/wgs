//
//  Park.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

struct CoordinatesAPI {

    struct  JSONAttributeKey {
        static let latitude = "latitude"
        static let longitude = "longitude"
    }

    // MARK: - Public attributes
    var latitude:String = ""
    var longitude:String = ""
}

extension CoordinatesAPI:Decodable {
    enum CoordinatesKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CoordinatesKeys.self)
        let latitude = try container.decode(String.self, forKey: .latitude)
        let longitude = try container.decode(String.self, forKey: .longitude)

        self.init(latitude: latitude, longitude: longitude)
    }
}

