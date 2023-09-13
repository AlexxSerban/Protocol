//
//  LocationManager.swift
//  Protocol
//
//  Created by Alex Serban on 12.09.2023.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion()
    @Published var location: CLLocation?
    let geocoder = CLGeocoder()
    @ObservedObject var locationData = LocationData()
    
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func getCurrentDateTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let now = Date()
        let currentTime = dateFormatter.string(from: now)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd.MM.yyyy"
        let nowDate = dateFormatter2.string(from: now)
        
        locationData.time = currentTime + " " + nowDate
    }
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude), completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Failed to retrieve address")
                return
            }
            
            if let placemarks = placemarks, let location = placemarks.first {
                self.locationData.city = location.administrativeArea ?? ""
                self.locationData.country = location.country ?? ""
                self.locationData.street = location.thoroughfare ?? ""
                self.locationData.streetNumber = location.subThoroughfare ?? ""
                self.locationData.postalCode = location.postalCode ?? ""
                
            } else {
                print("No Matching Address Found")
            }
        })
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        getCurrentDateTime()
    }
}
