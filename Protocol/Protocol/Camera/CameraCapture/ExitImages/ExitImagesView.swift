//
//  ExitImages.swift
//  Protocol
//
//  Created by Alex Serban on 12.10.2023.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct ExitImagesView: View {

    @EnvironmentObject var locationManager: LocationManager // Access the LocationManager through the environment
    @StateObject var viewModel = CameraCaptureModelView() // Create an instance of CameraCaptureModelView

    // Data
    @State private var selectedImage: UIImage? // Store the selected image
    @State private var exitPhotos: String = "exit."

    // Status
    @State private var isShowingImagePicker = false // Control whether the image picker is displayed
    @State private var isFirstImageCaptured = false // Track if the first image is captured
    @State private var isSecondImageCaptured = false // Track if the second image is captured
    @State private var isBothImagesCaptured = false // Track if both images are captured

    var body: some View {
        withAnimation(.easeInOut(duration: 0.5)) {
            VStack {
                if !isFirstImageCaptured {
                    // Display CaptureFirstImageView if the first image is not captured
                    CaptureFirstImageView(
                        isShowingImagePicker: $isShowingImagePicker,
                        selectedImage: $selectedImage,
                        isFirstImageCaptured: $isFirstImageCaptured,
                        viewModel: viewModel,
                        locationManager: locationManager,
                        entryOrExitType: $exitPhotos
                    )
                } else if !isSecondImageCaptured {
                    // Display CaptureSecondImageView if the second image is not captured
                    CaptureSecondImageView(
                        selectedImage: $selectedImage,
                        viewModel: viewModel,
                        locationManager: locationManager,
                        isSecondImageCaptured: $isSecondImageCaptured,
                        isBothImagesCaptured: $isBothImagesCaptured,
                        isShowingImagePicker: $isShowingImagePicker,
                        entryOrExitType: $exitPhotos
                    )
                } else if isBothImagesCaptured {
                    // Display DisplayBothImagesExitView if both images are captured
                    DisplayBothImagesExitView(viewModel: viewModel)
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            // Present the ImagePickerView as a sheet
            ImagePickerView(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
    }
}

struct ExitImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ExitImagesView()
            .environmentObject(LocationManager())
    }
}
