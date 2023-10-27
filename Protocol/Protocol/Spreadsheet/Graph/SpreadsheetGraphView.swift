//
//  SpreadsheetGraphView.swift
//  Protocol
//
//  Created by Alex Serban on 26.09.2023.
//

import SwiftUI
import Charts

struct SpreadsheetGraphView: View {
    
    @State var viewModel: GraphViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                GraphView(viewModel: viewModel)
                HStack {
                    Spacer()
                    Button {
                        viewModel.nextToExitPhoto.toggle()
                    } label: {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.nextToExitPhoto) {
                ExitImagesView()
            }
        }
        .onAppear {
            viewModel.updateXAxisValues()
        }
    }
}

struct SpreadsheetGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SpreadsheetGraphView(viewModel: GraphViewModel())
    }
}
