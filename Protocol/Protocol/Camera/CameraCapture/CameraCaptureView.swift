//
//  CameraCaptureView.swift
//  Protocol
//
//  Created by Alex Serban on 12.09.2023.
//
import SwiftUI
import CoreLocation
import CoreLocationUI

struct CameraCaptureView: View {

    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = CameraCaptureModelView()
    
    //Data
    @State private var selectedImage: UIImage?
    
    // Status
    @State private var isShowingImagePicker = false
    @State private var isFirstImageCaptured = false
    @State private var isSecondImageCaptured = false
    @State private var isBothImagesCaptured = false
    
    var body: some View {
        
        withAnimation(.easeInOut(duration: 0.5)){
            VStack {
                if !isFirstImageCaptured {
                    CaptureFirstImageView(
                        isShowingImagePicker: $isShowingImagePicker,
                        selectedImage: $selectedImage,
                        isFirstImageCaptured: $isFirstImageCaptured,
                        viewModel: viewModel,
                        locationManager: locationManager
                    )
                } else if !isSecondImageCaptured {
                    CaptureSecondImageView(
                        selectedImage: $selectedImage,
                        viewModel: viewModel,
                        locationManager: locationManager,
                        isSecondImageCaptured: $isSecondImageCaptured,
                        isBothImagesCaptured: $isBothImagesCaptured,
                        isShowingImagePicker: $isShowingImagePicker
                    )
                } else if isBothImagesCaptured {
                    DisplayBothImagesView(viewModel: viewModel)
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
    }
}

struct CameraCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        CameraCaptureView()
            .environmentObject(LocationManager())
    }
}


