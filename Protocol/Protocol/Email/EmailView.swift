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
        VStack(alignment: .center) {
            
            VStack {
                Text("Images")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                HStack(spacing: 20) {
                    ImageBlock(image: viewModel.protocolData.firstEntryImage, title: "First Entry")
                    ImageBlock(image: viewModel.protocolData.secondEntryImage, title: "Second Entry")
                    ImageBlock(image: viewModel.protocolData.firstExitImage, title: "First Exit")
                    ImageBlock(image: viewModel.protocolData.secondExitImage, title: "Second Exit")
                }
                .padding()
            }
            
            VStack {
                if viewModel.protocolData.pdfFileURL != nil {
                    Text("The PDF is attached")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 10)
                }
                else {
                    Text("The PDF is not attached")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 10)
                }
            }
            
            HStack {
                Button(action: {
                    viewModel.selectPDF()
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add PDF")
                    }
                    .padding()
                    .background(Color("ColorBox"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 10)
                Spacer()
                
                Button(action: {
                    viewModel.composeEmail()
                }) {
                    HStack {
                        Image(systemName: "envelope")
                        Text("Send Email")
                    }
                    .padding()
                    .background(Color("ColorBox"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.attachImages()
            viewModel.getPDF()
            viewModel.emailSubject = "Protocol files from \(viewModel.protocolData.constructor) - \(viewModel.protocolData.area) - \(viewModel.formattedDate) "
            viewModel.emailBody = "Hello, \nPlease find attached the files from activity \(viewModel.protocolData.area) - \(viewModel.protocolData.street) from \(viewModel.formattedDate). \nThe work was done by supervisor \(viewModel.protocolData.supervisor) which consisted of \(viewModel.protocolData.drillLength) meters. \nHave a nice day."
        }
    }
}


#Preview {
    EmailView()
}

struct ImageBlock: View {
    var image: UIImage?
    var title: String
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
