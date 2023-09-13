//
//  CameraCaptureView.swift
//  Protocol
//
//  Created by Alex Serban on 12.09.2023.
//
import Foundation
import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct CameraCaptureView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @EnvironmentObject var locationManager : LocationManager
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Button("Deschide Camera") {
                    isShowingImagePicker.toggle()
                }
            }
            
            VStack(alignment: .leading) {
                if let location = locationManager.location {
                    Text("Latitude: \(location.coordinate.latitude)")
                    Text("Longitude: \(location.coordinate.longitude)")
                    Text("Date and time: \(locationManager.locationData.time)")
                    Text("City: \(locationManager.locationData.city)")
                    Text("Country: \(locationManager.locationData.country)")
                    Text("Street: \(locationManager.locationData.street) \(locationManager.locationData.streetNumber)")
                    Text("Zipcode: \(locationManager.locationData.postalCode)")
                } else {
                    Text("Nu avem acces la locație. Vă rugăm să acordați permisiunea pentru a continua.")
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
        .onAppear {
            locationManager.reverseGeocoding(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            locationManager.getCurrentDateTime()
        }
    }
}



struct CameraCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        CameraCaptureView()
            .environmentObject(LocationManager())
    }
}

