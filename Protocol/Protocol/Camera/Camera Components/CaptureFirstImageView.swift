//
//  CaptureFirstImageView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//
import SwiftUI

struct CaptureFirstImageView: View {
    
    @Binding var isShowingImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @State private var isRemakeVisible = true
    
    @Binding var isFirstImageCaptured: Bool
    var viewModel: CameraCaptureModelView
    var locationManager: LocationManager
    
    var body: some View {
        VStack(spacing: 16) {
            if selectedImage == nil {
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack(spacing: 16) {
                        Text("Open the camera to take a photo and obtain location details.")
                            .font(.callout)
                            .foregroundColor(Color("Text"))
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Button(action: {
                            isShowingImagePicker.toggle()
                        }) {
                            Text("Capture First Image")
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
                        Image(uiImage: selectedImage ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .frame(width: 410, height: 410)
                            .scaledToFill()
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        
                        HStack(spacing: 16) {
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
                                    isFirstImageCaptured = true
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
                            .padding()
                        }
                        
                    }
                }
            }
        }
        .padding()
    }
}

struct CaptureFirstImageView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureFirstImageView(
            isShowingImagePicker: .constant(false),
            selectedImage: .constant(nil),
            isFirstImageCaptured: .constant(false),
            viewModel: CameraCaptureModelView(),
            locationManager: LocationManager()
        )
    }
}



