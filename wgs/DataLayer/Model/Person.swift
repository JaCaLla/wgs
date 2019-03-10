//
//  Person.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import MapKit
import UIKit

struct Person {

    var email:String = ""
    var first:String = ""
    var latitude:String = ""
    var longitude:String = ""
    var thumbnail:String = ""
    var large:String = ""

    private var imageLocalName:String?

    // MARK : - Constructors/Initializers
    init() {
        /* Construction without parameters */
    }

    var injectedDataManager = DataManager()

    init(email: String,
              first: String,
              latitude: String,
              longitude: String,
              thumbnail: String,
              large: String,
              image: UIImage?,
              dataManager:DataManager = DataManager()) {

        injectedDataManager = dataManager

        self.email      = email
        self.first      = first
        self.latitude   = latitude
        self.longitude  = longitude
        self.thumbnail  = thumbnail
        self.large      = large

        if let uwpLocalImage = image {
            self.set(image: uwpLocalImage)
        }
    }

    init(email: String,
         first: String,
         latitude: String,
         longitude: String,
         thumbnail: String,
         large: String,
         imageLocalName: String?,
         dataManager:DataManager = DataManager()) {

        var image:UIImage? = nil
        if let uwpImageLocalName = imageLocalName {
           image = dataManager.getImage(fileName: uwpImageLocalName)
        }

        self.init(email: email,
                  first: first,
                  latitude: latitude,
                  longitude: longitude,
                  thumbnail: thumbnail,
                  large: large,
                  image: image,
                  dataManager: dataManager)
    }

    init(personAPI:PersonAPI) {

        self.init(email: personAPI.email,
                  first: personAPI.name.first,
                  latitude: personAPI.location.coordinates.latitude,
                  longitude: personAPI.location.coordinates.longitude,
                  thumbnail: personAPI.picture.thumbnail,
                  large: personAPI.picture.large,
                  image: nil)
    }

    init(personEntity:PersonEntity) {

        self.init(email: personEntity.email,
                  first: personEntity.firstName,
                  latitude: personEntity.latitude,
                  longitude: personEntity.longitude,
                  thumbnail: personEntity.thumbnail,
                  large: personEntity.large,
                  imageLocalName: personEntity.imageLocalName)
    }

    // MARK: - Public methods
    func imageURL() -> URL {
        return URL(string: self.thumbnail) ?? URL(fileURLWithPath: "")
    }

    func imageLargeURL() -> URL {
        return URL(string: self.large) ?? URL(fileURLWithPath: "")
    }

    mutating func set(image:UIImage) {
        let filename = "\(Date().timeIntervalSince1970)"
        self.imageLocalName = filename
        injectedDataManager.save(imageName: filename, image: image)
    }

    func getImage() -> UIImage? {
        guard let uwpImageLocalName =  self.imageLocalName  else { return nil }
        return injectedDataManager.getImage(fileName: uwpImageLocalName)
    }

    func getImageName() -> String? {
        return self.imageLocalName
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {

        let tmpEqual = lhs.email == rhs.email &&
            lhs.first       == rhs.first &&
            lhs.latitude    == rhs.latitude &&
            lhs.longitude   == rhs.longitude &&
            lhs.thumbnail   == rhs.thumbnail &&
            lhs.large       == rhs.large

        if let lhsImageLocalName = lhs.imageLocalName,
            let rhsImageLocalName = rhs.imageLocalName {
            return tmpEqual && rhsImageLocalName == lhsImageLocalName
        } else if lhs.imageLocalName == nil &&
            rhs.imageLocalName == nil {
            return tmpEqual
        } else {
            return false
        }
    }
}
