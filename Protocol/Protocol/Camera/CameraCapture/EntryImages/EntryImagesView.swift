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

    @EnvironmentObject var locationManager: LocationManager
    @State var viewModel = CameraCaptureModelView()

    var body: some View {
        withAnimation(.easeInOut(duration: 0.5)) {
            VStack {
                if !viewModel.isFirstImageCaptured {
                    CaptureFirstImageView(
                        viewModel: viewModel,
                        locationManager: locationManager,
                        entryOrExitType: viewModel.entryPhotos
                    )
                } else if !viewModel.isSecondImageCaptured {
                    CaptureSecondImageView(
                        viewModel: viewModel,
                        locationManager: locationManager,
                        entryOrExitType: viewModel.entryPhotos
                    )
                } else if viewModel.isBothImagesCaptured {
                    DisplayBothImagesView(viewModel: viewModel)
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingImagePicker) {
            ImagePickerView(selectedImage: $viewModel.selectedImage, isPresented: $viewModel.isShowingImagePicker)
        }
    }
}

struct EntryImagesView_Previews: PreviewProvider {
    static var previews: some View {
        EntryImagesView()
            .environmentObject(LocationManager())
    }
}
