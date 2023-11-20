//
//  HomeView.swift
//  Protocol
//
//  Created by Alex Serban on 13.10.2023.
//

import SwiftUI

struct HomeView: View {
    @State var navigationToImages: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Text("Welcome!")
                    .font(.system(size: 56, weight: .bold))
                    .padding()

                Spacer()

                Button {
                    navigationToImages.toggle()
                } label: {
                    Text("Start a new activity")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color("ColorBox"))
                        .cornerRadius(15)
                }

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $navigationToImages) {
                EntryImagesView()
            }
        }
    }
}


#Preview {
    HomeView()
}
