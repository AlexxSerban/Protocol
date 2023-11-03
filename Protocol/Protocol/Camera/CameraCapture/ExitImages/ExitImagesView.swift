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

    @EnvironmentObject var locationManager: LocationManager
    @State var viewModel = CameraCaptureModelView()


    var body: some View {
        withAnimation(.easeInOut(duration: 0.5)) {
            VStack {
                if !viewModel.isFirstImageCaptured {
                    CaptureFirstImageView(
                        viewModel: viewModel,
                        locationManager: locationManager,
                        entryOrExitType: viewModel.exitPhotos
                    )
                } else if !viewModel.isSecondImageCaptured {
                    CaptureSecondImageView(
                        viewModel: viewModel,
                        locationManager: locationManager,
                        entryOrExitType: viewModel.exitPhotos
                    )
                } else if viewModel.isBothImagesCaptured {
                    DisplayBothImagesExitView(viewModel: viewModel)
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingImagePicker) {
            ImagePickerView(selectedImage: $viewModel.selectedImage, isPresented: $viewModel.isShowingImagePicker)
        }
    }
}

struct ExitImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ExitImagesView()
            .environmentObject(LocationManager())
    }
}
