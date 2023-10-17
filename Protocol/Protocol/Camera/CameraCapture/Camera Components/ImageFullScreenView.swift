//
//  ImageFullScreenView.swift
//  Protocol
//
//  Created by Alex Serban on 15.09.2023.
//

import SwiftUI

struct ImageFullScreenView: View {
    @Environment(\.presentationMode) var presentationMode // Environment property to manage presentation mode
    let image: UIImage // The image to be displayed in fullscreen

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ImageFullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFullScreenView(image: UIImage(named: "example_image")!)
    }
}
