//
//  HeaderSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 23.10.2023.
//

import SwiftUI

struct HeaderSpreadsheetView: View {
    
    @State var viewModel = HeaderSpreadsheetViewModel()
    
    var body: some View {
        
        VStack(spacing: 30) {
            VStack {
                HStack(spacing: 0) {
                    Image("IconTechnoskopic")
                        .padding(8)
                    Spacer()
                    Text("HDD PROTOCOL")
                        .bold()
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .border(Color.black, width: 1)
                
                Text("GENERAL INFO")
                    .bold()
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.mint)
                    .border(Color.black, width: 1)
                
                ForEach(0..<$viewModel.protocolData.firstColumn.count - 1, id: \.self) { row in
                    HStack(spacing: 0) {
                        Divider()
                        Text(viewModel.protocolData.cellValues[row][0].text)
                            .bold()
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(8)
                        Divider()
                            .overlay(Color.black)
                        Text(viewModel.protocolData.cellValues[row][1].text)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(8)
                    }
                    .border(Color.black, width: 1)
                }
                
                HStack(spacing: 0) {
                    Divider()
                    Text(viewModel.protocolData.cellValues[13][0].text)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(8)
                    Spacer()
                    Divider()
                        .overlay(Color.black)
                    Spacer()
                    if let signatureImage = viewModel.protocolData.cellValues[13][1].image {
                        Image(uiImage: signatureImage)
                            .resizable()
                            .frame(width: 200, height: 200)
                    } else {
                        Text("No Signature")
                            .padding(8)
                    }
                    Spacer()
                }
                .border(Color.black, width: 1)
            }
            .font(.body)
            .padding()
            .onAppear {
                viewModel.initializeSpreadsheetFirm()
            }
        }
    }
}

struct HeaderSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        return HeaderSpreadsheetView()
    }
}



