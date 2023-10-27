//
//  DisplayBothImagesExitView.swift
//  Protocol
//
//  Created by Alex Serban on 16.10.2023.
//

import SwiftUI

struct DisplayBothImagesExitView: View {
    var viewModel: CameraCaptureModelView // The view model for managing captured images

    @State private var isImage1FullScreen = false // Control fullscreen display for the first image
    @State private var isImage2FullScreen = false // Control fullscreen display for the second image
    @State private var toMainFirmSpreasheet = false // Control navigation to the MainFirmSpreadsheetView

    var body: some View {
        NavigationStack {
            withAnimation(.easeInOut(duration: 0.5)) {
                VStack {
                    HStack {
                        Image(uiImage: viewModel.model.firstEntryImage ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .onTapGesture {
                                isImage1FullScreen.toggle()
                            }
                            .fullScreenCover(isPresented: $isImage1FullScreen) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    ImageFullScreenView(image: viewModel.model.firstEntryImage ?? UIImage(systemName: "photo")!)
                                }
                            }

                        Image(uiImage: viewModel.model.secondEntryImage ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .onTapGesture {
                                isImage2FullScreen.toggle()
                            }
                            .fullScreenCover(isPresented: $isImage2FullScreen) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    ImageFullScreenView(image: viewModel.model.secondEntryImage ?? UIImage(systemName: "photo")!)
                                }
                            }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        toMainFirmSpreasheet.toggle()
                    }) {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()

                }
                .navigationTitle("Images")
            }

            .navigationDestination(isPresented: $toMainFirmSpreasheet) {
                MainHeaderSpreadsheetView()
            }
        }
    }
}

struct DisplayBothImagesExitView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayBothImagesExitView(
            viewModel: CameraCaptureModelView()
        )
    }
}
