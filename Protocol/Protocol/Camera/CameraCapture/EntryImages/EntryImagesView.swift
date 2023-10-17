//
//  CameraCaptureView.swift
//  Protocol
//
//  Created by Alex Serban on 12.09.2023.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct EntryImagesView: View {

    @EnvironmentObject var locationManager: LocationManager // Access the LocationManager through the environment
    @StateObject var viewModel = CameraCaptureModelView() // Create an instance of CameraCaptureModelView

    // Data
    @State private var selectedImage: UIImage? // Store the selected image
    @State private var firstPhotoNumber: String = "First" // Label for the first photo
    @State private var secondPhotoNumber: String = "Second" // Label for the second photo

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
                        numerOfPhoto: $firstPhotoNumber,
                        isBothImagesCaptured: $isBothImagesCaptured,
                        isSecondImageCaptured: $isSecondImageCaptured,
                        isFirstImageCaptured: $isBothImagesCaptured,
                        viewModel: viewModel,
                        locationManager: locationManager
                    )
                } else if !isSecondImageCaptured {
                    // Display CaptureFirstImageView if the second image is not captured
                    CaptureFirstImageView(
                        isShowingImagePicker: $isShowingImagePicker,
                        selectedImage: $selectedImage,
                        numerOfPhoto: $firstPhotoNumber,
                        isBothImagesCaptured: $isBothImagesCaptured,
                        isSecondImageCaptured: $isSecondImageCaptured,
                        isFirstImageCaptured: $isBothImagesCaptured,
                        viewModel: viewModel,
                        locationManager: locationManager
                    )
                } else if isBothImagesCaptured {
                    // Display DisplayBothImagesView if both images are captured
                    DisplayBothImagesView(viewModel: viewModel)
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            // Present the ImagePickerView as a sheet
            ImagePickerView(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
    }
}

struct EntryImagesView_Previews: PreviewProvider {
    static var previews: some View {
        EntryImagesView()
    }
}
