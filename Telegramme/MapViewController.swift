//
//  MapViewController.swift
//  Telegramme
//
//  Created by MAD2_P02 on 8/1/20.
//  Copyright © 2020 MAD2_P02. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    let regionRadius:CLLocationDistance = 250
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        map.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GoToPoly()
        
        locationManager.delegate = locationDelegate
        
        locationDelegate.locationCallback = { location in self.latestLocation = location
            self.centerMapOnLocation(location: location)
            
            let annotation:MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "Me!"
            
            self.map.addAnnotation(annotation)
        }
    }
    
    func GoToPoly()
    
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler: {p,k in}
    
    let initialLocation = CLLocation(latitude: p![0].location!.coordinate.latitude, longtidude:p![0].location!.coordinate.longitude)
    self.centerMapOnLocation(location: initialLocation)
    
    let annotation:MKPointAnnotation = MKPointAnnotation()
    annotation.coordinate = initialLocation.coordinate
    annotation.title = "Ngee Ann Polytechnic"
    annotation.subtitle = "School of ICT"
    self.map.addAnnotation(annotation)
    })
}

