//
//  LocationData.swift
//  Protocol
//
//  Created by Alex Serban on 13.09.2023.
//

import Foundation

class LocationData: ObservableObject {
    
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var city: String
    @Published var country: String
    @Published var street: String
    @Published var streetNumber: String
    @Published var postalCode: String
    @Published var time: String

    init (
        latitude : Double = 0.0,
        longitude: Double = 0.0,
        city: String = "",
        country: String = "",
        street: String = "",
        streetNumber: String = "",
        postalCode: String = "",
        time: String = ""
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
        self.country = country
        self.street = street
        self.streetNumber = streetNumber
        self.postalCode = postalCode
        self.time = time
    }
}
