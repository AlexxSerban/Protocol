//
//  CaptureSecondImageView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI

// Define a SwiftUI view named CaptureSecondImageView
struct CaptureSecondImageView: View {
    @Binding var selectedImage: UIImage? // Store the selected image
    @ObservedObject var viewModel: CameraCaptureModelView // The view model for capturing images
    @ObservedObject var locationManager: LocationManager // The location manager
    @Binding var isSecondImageCaptured: Bool // Track if the second image is captured
    @Binding var isBothImagesCaptured: Bool // Track if both images are captured
    @Binding var isShowingImagePicker: Bool // Control whether the image picker is displayed
    @State private var isRemakeVisible = false // Control the visibility of the "Remake" button
    
    var body: some View {
        VStack(spacing: 16) {
            if selectedImage == nil {
                // Display this view when no image is selected
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack{
                        VStack(spacing: 16) {
                            Text("Location Details")
                                .font(.headline)
                                .foregroundColor(Color("Text"))
                                .padding()
                            
                            Text("Street: \(locationManager.locationData.street) \(locationManager.locationData.streetNumber)")
                            Text("City: \(locationManager.locationData.postalCode) \(locationManager.locationData.city)")
                            Text("Country: \(locationManager.locationData.country)")
                            Text("Coord: \(locationManager.locationData.latitude) \(locationManager.locationData.longitude)")
                        }
                        Text("Open the camera to take the second photo and obtain location details.")
                            .font(.callout)
                            .foregroundColor(Color("Text"))
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Button(action: {
                            isShowingImagePicker.toggle()
                        }) {
                            Text("Open the camera")
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
                // Display this view when an image is selected
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack(spacing: 16) {
                        Image(uiImage: selectedImage ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .frame(width: 410, height: 410)
                            .scaledToFill()
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        
                        HStack (spacing: 16) {
                            Button(action: {
                                isShowingImagePicker.toggle()
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
                                if let imageWithLocationDetails = viewModel.addLocationDetailsToImage(selectedImage ?? UIImage(systemName: "photo")!, locationData: locationManager.locationData) {
                                    viewModel.saveImageData(image: imageWithLocationDetails)
                                    selectedImage = nil
                                    isBothImagesCaptured = true
                                    isSecondImageCaptured = true
                                    isRemakeVisible = false
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
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct CaptureSecondImageView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureSecondImageView(
            selectedImage: .constant(nil),
            viewModel: CameraCaptureModelView(),
            locationManager: LocationManager(),
            isSecondImageCaptured: .constant(false),
            isBothImagesCaptured: .constant(false),
            isShowingImagePicker: .constant(false)
        )
    }
}
