//
//  HeaderDetailsSpreadsheet.swift
//  Protocol
//
//  Created by Alex Serban on 05.10.2023.
//

import SwiftUI

struct HeaderDetailsSpreadsheetView: View {
    
    @State var viewModel: HeaderSpreadsheetViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                List {
                    // Header of the spreadsheet
                    HStack(spacing: 0) {
                        Image("IconTechnoskopic")
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
                    
                    // Section for general info
                    Text("GENERAL INFO")
                        .bold()
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.mint)
                        .border(Color.black, width: 1)
                    
                    // Body cells
                    ForEach(0..<$viewModel.protocolData.firstColumn.count - 1, id: \.self) { row in
                        HStack(spacing: 0) {
                            Divider()
                            
                            TextField("", text: $viewModel.protocolData.cellValues[row][0].text)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Divider()
                                .overlay(Color.black)
                            
                            TextField("", text: $viewModel.protocolData.cellValues[row][1].text)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                
                        }
                        .border(Color.black, width: 1)
                    }
                    
                    // Row for contractor's signature
                    HStack(spacing: 0) {
                        Divider()
                        
                        TextField("", text: $viewModel.protocolData.cellValues[13][0].text)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Divider()
                            .overlay(Color.black)
                        
                        Spacer()
                        
                        if let signatureImage = viewModel.protocolData.cellValues[13][1].image {
                            Image(uiImage: signatureImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                        } else {}
                        
                        Spacer()
                    }.border(Color.black, width: 1)
                }
                .font(.body)
                .padding()
                
                HStack(spacing: 16) {
                    Spacer()
                    Button(action: {
                        viewModel.checkCellValues()
                    }) {
                        Text("Next")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $viewModel.isAlertPresented) {
                        Alert(
                            title: Text("Incomplete Data"),
                            message: Text("Please fill in all fields and select a signature photo."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationDestination(isPresented: $viewModel.isDataComplete, destination: {
            ProtocolPDFView()
//            EmailView()
            
        })
        .onAppear {
            viewModel.initializeSpreadsheetFirm()
        }
    }
}


struct FirmDetailsSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailsSpreadsheetView(viewModel: HeaderSpreadsheetViewModel())
    }
}






