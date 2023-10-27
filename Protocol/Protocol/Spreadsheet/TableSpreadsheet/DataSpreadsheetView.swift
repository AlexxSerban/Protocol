//
//  DataSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 19.09.2023.
//

import SwiftUI

struct DataSpreadsheetView: View {
    
    @State var viewModel: SpreadsheetViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            // Input field for the number of meters
            VStack {
                Text("Enter the number of meters for the job")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                TextField("Enter the number of meters", text: $viewModel.protocolData.numberOfMeters)
                    .frame(width: 350)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            // Input field for the size of the first rod
            VStack {
                Text("Enter the size of the first rod")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                TextField("Enter the size of the first rod", text: $viewModel.protocolData.firstRodSize)
                    .frame(width: 350)
                    .keyboardType(.numbersAndPunctuation)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            // Picker for selecting the rod size
            VStack {
                Text("Choose the rod size for this job")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Picker("Rod Size", selection: $viewModel.protocolData.selectedRodSize) {
                    ForEach(RodSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                            .font(.largeTitle)
                    }
                }
                .pickerStyle(.menu)
            }
            
            // Button to proceed
            Button(action: {
                if !viewModel.protocolData.numberOfMeters.isEmpty && !viewModel.protocolData.firstRodSize.isEmpty {
                    viewModel.showSpreadsheet = true
                }
                else {
                    viewModel.dataSpreadsheetShowAlert = true
                }
            }) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Alert for incomplete data
            .alert(isPresented: $viewModel.dataSpreadsheetShowAlert) {
                Alert(
                    title: Text("Attention"),
                    message: Text("Please enter both the number of meters and the size of the first rod."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }
}

// Preview for testing
struct DataSpreadsheetView_Previews: PreviewProvider {
    
    static var previews: some View {
        DataSpreadsheetView(viewModel: SpreadsheetViewModel())
    }
}
