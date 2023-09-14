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
    @ObservedObject var viewModel = CameraCaptureModelView()
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .scaledToFit()
                
                Button("Salvează cu detalii de locație") {
                    if let imageWithLocationDetails = viewModel.addLocationDetailsToImage(image, locationData: locationManager.locationData) {
//                        $viewModel.checkAndRequestPermission // Verificați și solicitați permisiunea de a accesa biblioteca de fotografii
                        UIImageWriteToSavedPhotosAlbum(imageWithLocationDetails, nil, nil, nil)
                    }
                }

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
            locationManager.locationData.latitude = locationManager.location?.coordinate.latitude ?? 0.0
            locationManager.locationData.longitude = locationManager.location?.coordinate.longitude ?? 0.0
            locationManager.reverseGeocoding(latitude: (locationManager.location?.coordinate.latitude) ?? 0.0, longitude: (locationManager.location?.coordinate.longitude) ?? 0.0)
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
