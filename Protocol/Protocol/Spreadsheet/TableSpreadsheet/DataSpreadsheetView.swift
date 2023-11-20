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
            VStack {
                Text("Enter the number of meters for the job")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Enter the number of meters", text: $viewModel.protocolData.numberOfMeters)
                    .font(.subheadline)
                    .frame(width: 350)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            VStack {
                Text("Enter the size of the first rod")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Enter the size of the first rod", text: $viewModel.protocolData.firstRodSize)
                    .font(.subheadline)
                    .frame(width: 350)
                    .keyboardType(.numbersAndPunctuation)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            VStack {
                Text("Choose the rod size for this job")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Picker("Rod Size", selection: $viewModel.protocolData.selectedRodSize) {
                    ForEach(RodSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                            .font(.subheadline)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding()
            
            Button(action: {
                if !viewModel.protocolData.numberOfMeters.isEmpty && !viewModel.protocolData.firstRodSize.isEmpty {
                    viewModel.showSpreadsheet = true
                }
                else {
                    viewModel.dataSpreadsheetShowAlert = true
                }
            }) {
                Text("Next")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color("ColorBox"))
                    .cornerRadius(15)
            }
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


struct DataSpreadsheetView_Previews: PreviewProvider {
    
    static var previews: some View {
        DataSpreadsheetView(viewModel: SpreadsheetViewModel())
    }
}
