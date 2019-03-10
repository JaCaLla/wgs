//
//  ImagePersonTVC.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit
import MapKit

class MapPersonTVC: UITableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!

    // MARK : - Public attributes
    var person:Person? {
        didSet {
            guard let uwpPerson = person else { return }
            self.refreshView(person: uwpPerson)
        }
    }

    // MARK: - Private/Internal
    private func refreshView(person:Person) {

        let latitude = Double(person.latitude) ?? 0
        let longitude = Double(person.longitude) ?? 0
        let location = CLLocation(latitude: latitude,
                                  longitude: longitude)

        // Center map around person with 5000 KM radious
        let regionRadius: CLLocationDistance = 1000 * 5000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        // Place pin annotation
        let annotation = MKPointAnnotation()
        annotation.title = person.first
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
    }
}
