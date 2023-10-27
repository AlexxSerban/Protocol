//
//  SpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 15.09.2023.
//

import SwiftUI
import Foundation

struct SpreadsheetView: View {
    @State var viewModel: SpreadsheetViewModel
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            TableSpreadsheetView(viewModel: viewModel)
            
            HStack(spacing: 16) {
                // Input field to update the last rod length
                TextField("Enter the number of meters for the last rod", text: $viewModel.protocolData.userEnteredValue)
                    .frame(width: 150)
                    .keyboardType(.numbersAndPunctuation)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                // Button to update the last rod length
                Button(action: {
                    if let enteredValue = Float(viewModel.protocolData.userEnteredValue) {
                        let lastRow = viewModel.protocolData.numberOfRowsCalculated - 1
                        let difference = Float(viewModel.protocolData.selectedRodSize.metersValue) - enteredValue
                        viewModel.protocolData.cellValuesString[lastRow][0] = String(format: "%.2f", difference)
                    }
                }) {
                    Text("Update")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                // Button to proceed to the next step
                Button(action: {
                    if viewModel.checkTableCompletion() {
                        viewModel.showGraph = true
                        print("Table is complete. Perform the Next action.")
                    } else {
                        viewModel.spreadsheetShowAlert = true
                    }
                }) {
                    Text("Next")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            viewModel.generateTableContent()
        }
    }
}

// Preview for testing
struct SpreadsheetView_Previews: PreviewProvider {
    
    @State static var viewModel: SpreadsheetViewModel = SpreadsheetViewModel()
    
    static var previews: some View {
        SpreadsheetView(viewModel: viewModel)
    }
}
