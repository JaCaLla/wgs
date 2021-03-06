//
//  Park.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 03/02/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import UIKit

struct PersonAPI {

    struct  JSONAttributeKey {
        static let name = "name"
        static let email = "email"
        static let picture = "picture"
        static let location = "location"
        static let id       = "id"
    }

    // MARK: - Public attributes
    var name:Name = Name()
    var email:String = ""
    var picture:Picture = Picture()
    var location:Location = Location()
    var id:Id = Id()
}

extension PersonAPI:Decodable {
    enum ParkKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case picture = "picture"
        case location = "location"
        case id   = "id"
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: ParkKeys.self)
        let name = try container.decode(Name.self, forKey: .name)
        let email = try container.decode(String.self, forKey: .email)
        let picture = try container.decode(Picture.self , forKey: .picture)
        let location = try container.decode(Location.self, forKey: .location)
        let id = try container.decode(Id.self, forKey: .id)

        self.init(name: name, email: email, picture:picture, location:location, id:id)
    }
}

