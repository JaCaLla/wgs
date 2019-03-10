//
//  PersonEntity.swift
//  wgs
//
//  Created by 08APO0516 on 08/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import RealmSwift

class PersonEntity: Object {

    // MARK: - Persisted attributes
     @objc dynamic var personId = UUID().uuidString

    @objc dynamic var email:String              = ""
    @objc dynamic var firstName:String          = ""
    @objc dynamic var latitude:String           = ""
    @objc dynamic var longitude:String          = ""
    @objc dynamic var thumbnail:String          = ""
    @objc dynamic var large:String              = ""
    @objc dynamic var imageLocalName:String?    = ""

    @objc dynamic var creation:Double = Date().timeIntervalSince1970

    // MARK: - Realm
    override class func primaryKey() -> String? {
        return "personId"
    }

    override class func indexedProperties() -> [String] {
        return ["email","first"]
    }

    override static func ignoredProperties() -> [String] {
        return []
    }

    //  MARK: - Constructors / Initializer
    convenience init(email: String,
         first: String,
         latitude: String,
         longitude: String,
         thumbnail: String,
         large:String,
         imageLocalName: String?) {

        self.init()
        self.email      = email
        self.firstName  = first
        self.latitude   = latitude
        self.longitude  = longitude
        self.thumbnail  = thumbnail
        self.large      = large

        self.imageLocalName = imageLocalName
    }

    convenience init(person:Person) {

        self.init(email: person.email,
                  first: person.first,
                  latitude: person.latitude,
                  longitude: person.longitude,
                  thumbnail: person.thumbnail,
                  large: person.large,
                  imageLocalName: person.getImageName())
    }
}
