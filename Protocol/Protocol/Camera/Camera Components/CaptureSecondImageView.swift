//
//  CaptureSecondImageView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI

struct CaptureSecondImageView: View {
    @Binding var selectedImage: UIImage?
    var viewModel: CameraCaptureModelView
    var locationManager: LocationManager
    @Binding var isSecondImageCaptured: Bool
    @Binding var isBothImagesCaptured: Bool
    @Binding var isShowingImagePicker: Bool
    @State private var isRemakeVisible = false
    
    var body: some View {
        VStack(spacing: 16) {
            if selectedImage == nil {
                withAnimation(.easeInOut(duration: 0.5)) {
                    VStack{
                        Text("Open the camera to take a photo and obtain location details.")
                            .font(.callout)
                            .foregroundColor(Color("Text"))
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Button(action: {
                            isShowingImagePicker.toggle()
                        }) {
                            Text("Capture Second Image")
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

