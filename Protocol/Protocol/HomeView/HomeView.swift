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
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    navigationToImages.toggle()
                } label: {
                    Text("Start a new activity")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
                
            }
            .navigationDestination(isPresented: $navigationToImages) {
                EntryImagesView()
            }
        }
    }
}

#Preview {
    HomeView()
}
