//
//  EmailView.swift
//  Protocol
//
//  Created by Alex Serban on 29.10.2023.
//

import SwiftUI
import PDFKit

struct EmailView: View {
    @State var viewModel = EmailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Images")
                .font(.title)
                .bold()
            HStack {
                if let image = viewModel.protocolData.firstEntryImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                
                if let image = viewModel.protocolData.secondEntryImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                if let image = viewModel.protocolData.firstExitImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                
                if let image = viewModel.protocolData.secondExitImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
            }
            .padding()
            
            HStack {
                Button(action: {
                    viewModel.selectPDF()
                }) {
                    Text("Adaugă PDF")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
                
                Button(action: {
                    viewModel.composeEmail()
                }) {
                    Text("Trimite e-mail")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                if viewModel.protocolData.pdfFileURL != nil {
                    
                }
            }
                
            }
            .padding()
            .onAppear {
                viewModel.attachImages()
                viewModel.getPDF()
            }
        }
    }
    
    
    #Preview {
        EmailView()
    }
