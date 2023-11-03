//
//  DisplayBothImagesView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI


struct DisplayBothImagesView: View {
    @State var viewModel: CameraCaptureModelView // The view model for managing captured images

    @State private var isImage1FullScreen = false // Control fullscreen display for the first image
    @State private var isImage2FullScreen = false // Control fullscreen display for the second image
    @State private var toMainSpreasheet = false // Control navigation to the MainSpreadsheetView

    var body: some View {
        NavigationStack {
            withAnimation(.easeInOut(duration: 0.5)) {
                VStack {
                    HStack {
                        Image(uiImage: viewModel.protocolData.firstEntryImage ?? UIImage(systemName: "photo")!)
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
                                    ImageFullScreenView(image: viewModel.protocolData.firstEntryImage ?? UIImage(systemName: "photo")!)
                                }
                            }

                        Image(uiImage: viewModel.protocolData.secondEntryImage ?? UIImage(systemName: "photo")!)
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
                                    ImageFullScreenView(image: viewModel.protocolData.secondEntryImage ?? UIImage(systemName: "photo")!)
                                }
                            }
                    }
                    .padding(.horizontal)
                    Button(action: {
                        toMainSpreasheet.toggle()
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
            .navigationDestination(isPresented: $toMainSpreasheet) {
                MainSpreadsheetView()
            }
        }
    }
}

struct DisplayBothImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayBothImagesView(
            viewModel: CameraCaptureModelView()
        )
    }
}
