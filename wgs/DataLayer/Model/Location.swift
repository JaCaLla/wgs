//
//  Park.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

struct Location {

    struct  JSONAttributeKey {
        static let city = "city"
        static let coordinates = "coordinates"
    }

    // MARK: - Public attributes
    var city:String = ""
    var coordinates:Coordinates = Coordinates()
}

extension Location:Decodable {
    enum LocationKeys: String, CodingKey {
        case city = "city"
        case coordinates = "coordinates"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: LocationKeys.self)
        let city = try container.decode(String.self, forKey: .city)
        let coordinates  = try container.decode(Coordinates.self, forKey: .coordinates)

        self.init(city: city, coordinates: coordinates)
    }
}

