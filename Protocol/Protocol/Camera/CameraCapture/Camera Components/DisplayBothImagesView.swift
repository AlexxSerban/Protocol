//
//  DisplayBothImagesView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI


struct DisplayBothImagesView: View {
    @State var viewModel: CameraCaptureModelView

    @State private var isImage1FullScreen = false
    @State private var isImage2FullScreen = false
    @State private var toMainSpreasheet = false

    var body: some View {
        NavigationStack {
            withAnimation(.easeInOut(duration: 0.5)) {
                VStack {
                    HStack {
                        VStack {
                            Text("First Image")
                            Image(uiImage: viewModel.protocolData.firstEntryImage ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 300, maxHeight: 300)
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
                        }
                        
                        VStack {
                            Text("Second Image")
                            Image(uiImage: viewModel.protocolData.secondEntryImage ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 300, maxHeight: 300)
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
                    }
                    .padding(.horizontal)
                    Button(action: {
                        toMainSpreasheet.toggle()
                    }) {
                        Text("Next")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color("ColorBox"))
                            .cornerRadius(15)
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
