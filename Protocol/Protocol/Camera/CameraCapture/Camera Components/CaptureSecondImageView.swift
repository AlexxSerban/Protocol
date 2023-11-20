//
//  CaptureSecondImageView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI

// Define a SwiftUI view named CaptureSecondImageView
struct CaptureSecondImageView: View {
    @State var viewModel: CameraCaptureModelView
    @StateObject var locationManager: LocationManager

    var entryOrExitType: String
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.selectedImage == nil {
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 36) {
                            
                            Text("Take the second photo for " + entryOrExitType)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(Color("Text"))
                                .multilineTextAlignment(.leading)
                            
                            Text("Location Details")
                                .font(.title2)
                                .foregroundColor(Color("Text"))
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("Street: ")
                                    .font(.title3)
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                                Text("\(locationManager.locationData.street) \(locationManager.locationData.streetNumber)")
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Text("City: ")
                                    .font(.title3)
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                                Text("\(locationManager.locationData.postalCode) \(locationManager.locationData.city)")
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Text("Country: ")
                                    .font(.title3)
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                                Text("\(locationManager.locationData.country)")
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Text("Coord: ")
                                    .font(.title3)
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                                Text("\(locationManager.locationData.latitude)N \(locationManager.locationData.longitude)E")
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.bold)
                            }
                            
                        }
                        .padding()
                        
                        Button(action: {
                            viewModel.isShowingImagePicker.toggle()
                        }) {
                            Text("Camera")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 250, height: 50)
                                .background(Color("ColorBox"))
                                .cornerRadius(15)
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
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 520, maxHeight: 500)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        
                        HStack (spacing: 16) {
                            Button(action: {
                                viewModel.isShowingImagePicker.toggle()
                            }) {
                                Text("Remake")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color("ColorBox"))
                                    .cornerRadius(15)
                            }
                            
                            Button(action: {
                                if let imageWithLocationDetails = viewModel.addLocationDetailsToImage(viewModel.selectedImage ?? UIImage(systemName: "photo")!, locationData: locationManager.locationData) {
                                    viewModel.saveImagesData(image: imageWithLocationDetails,
                                                             locationManager: locationManager,
                                                             entryOrExitType: entryOrExitType)
                                    viewModel.selectedImage = nil
                                    viewModel.isBothImagesCaptured = true
                                    viewModel.isSecondImageCaptured = true
                                    viewModel.isRemakeVisible = false
                                }
                            }) {
                                Text("Save image")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color("ColorBox"))
                                    .cornerRadius(15)
                            }
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

struct CaptureSecondImageView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureSecondImageView(
            viewModel: CameraCaptureModelView(),
            locationManager: LocationManager(),
            entryOrExitType: ""
        )
    }
}
