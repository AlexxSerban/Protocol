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
                
                HeaderSpreadsheetView(viewModel: viewModel)
                
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






