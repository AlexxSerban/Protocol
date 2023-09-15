//
//  DisplayBothImagesView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import SwiftUI

struct DisplayBothImagesView: View {
    var viewModel: CameraCaptureModelView
    
    @State private var isImage1FullScreen = false
    @State private var isImage2FullScreen = false 

    var body: some View {
        NavigationView {
            withAnimation(.easeInOut(duration: 0.5)) {
                VStack {
                    HStack {
                        // Image 1
                        Image(uiImage: viewModel.entryImagesData.firstImage ?? UIImage(systemName: "photo")!)
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
                                    ImageFullScreenView(image: viewModel.entryImagesData.firstImage ?? UIImage(systemName: "photo")!)
                                }
                            }
                        
                        // Image 2
                        Image(uiImage: viewModel.entryImagesData.secondImage ?? UIImage(systemName: "photo")!)
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
                                    ImageFullScreenView(image: viewModel.entryImagesData.secondImage ?? UIImage(systemName: "photo")!)
                                }
                            }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
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



