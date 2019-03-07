//
//  Person.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation

struct Person {

    var email:String = ""
    var first:String = ""
    var latitude:String = ""
    var longitude:String = ""
    var thumbnail:String = ""

    // MARK : - Constructors/Initializers
    init(email: String,
              first: String,
              latitude: String,
              longitude: String,
              thumbnail: String) {
        
        self.email = email
        self.first = first
        self.latitude = latitude
        self.longitude = longitude
        self.thumbnail = thumbnail
    }

    init(personAPI:PersonAPI) {

        self.init(email: personAPI.email,
                  first: personAPI.name.first,
                  latitude: personAPI.location.coordinates.latitude,
                  longitude: personAPI.location.coordinates.longitude,
                  thumbnail: personAPI.picture.thumbnail)

    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.email == rhs.email &&
        lhs.first == rhs.first &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.thumbnail == rhs.thumbnail
    }
}
