//
//  CaptureFirstImageView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI

struct CaptureFirstImageView: View {
    
    @State var viewModel: CameraCaptureModelView
    @StateObject var locationManager: LocationManager
    var entryOrExitType: String

    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.selectedImage == nil {
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack(spacing: 16) {
                        VStack(spacing: 16) {
                            
                            Text("Open the camera to take the first photo for " + entryOrExitType)
                                .font(.callout)
                                .foregroundColor(Color("Text"))
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            
                            Text("Location Details")
                                .font(.headline)
                                .foregroundColor(Color("Text"))
                                .padding()
                            
                            Text("Street: \(locationManager.locationData.street) \(locationManager.locationData.streetNumber)")
                            Text("City: \(locationManager.locationData.postalCode) \(locationManager.locationData.city)")
                            Text("Country: \(locationManager.locationData.country)")
                            Text("Coord: \(locationManager.locationData.latitude) \(locationManager.locationData.longitude)")
                        }
                      
                        Button(action: {
                            viewModel.isShowingImagePicker.toggle()
                        }) {
                            Text("Camera")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                }
            }
            else {
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack(spacing: 16) {
                        Image(uiImage: viewModel.selectedImage ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .frame(width: 410, height: 410)
                            .scaledToFill()
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                viewModel.isShowingImagePicker.toggle()
                            }) {
                                Text("Remake")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.mint)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                if let imageWithLocationDetails = viewModel.addLocationDetailsToImage(viewModel.selectedImage ?? UIImage(systemName: "photo")!, locationData: locationManager.locationData) {
                                    viewModel.saveImagesData(image: imageWithLocationDetails,
                                                             locationManager: locationManager,
                                                             entryOrExitType: entryOrExitType)
                                    viewModel.selectedImage = nil
                                    viewModel.isFirstImageCaptured = true
                                    viewModel.isRemakeVisible = false
                                    print("The first photo has been taken")
                                }
                            }) {
                                Text("Save image")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            locationManager.configureLocationData()
        }
    }
}

struct CaptureFirstImageView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureFirstImageView(
            viewModel: CameraCaptureModelView(),
            locationManager: LocationManager(),
            entryOrExitType: ""
        )
    }
}
