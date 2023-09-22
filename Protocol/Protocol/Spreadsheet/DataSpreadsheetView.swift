//
//  DataSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 19.09.2023.
//

import SwiftUI

struct DataSpreadsheetView: View {
    
    @Binding var numberOfMeters: String
    @Binding var selectedRodSize: RodSize
    @Binding var showSpreadsheet: Bool
    @Binding var dataSpreadsheetShowAlert: Bool
    @Binding var firstRodSize: String
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                Text("Enter the number of meters for the job")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                TextField("Enter the number of meters", text: $numberOfMeters)
                    .frame(width: 350)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            VStack {
                Text("Enter the size of the first rod")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                TextField("Enter the size of the first rod", text: $firstRodSize)
                    .frame(width: 350)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            VStack {
                Text("Choose the rod size for this job")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Picker("Rod Size", selection: $selectedRodSize) {
                    ForEach(RodSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                            .font(.largeTitle)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Button(action: {
                if !numberOfMeters.isEmpty && !firstRodSize.isEmpty {
                    showSpreadsheet = true
                }
                else {
                    dataSpreadsheetShowAlert = true
                }
                print("\(numberOfMeters)")
                print("\(firstRodSize)")
                print("\(showSpreadsheet)")
            }) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $dataSpreadsheetShowAlert) {
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
    @State static var numberOfMeters: String = ""
    @State static var firstRodSize: String = ""
    @State static var selectedRodSize: RodSize = .meter128288
    @State static var showSpreadsheet: Bool = false
    @State static var dataSpreadsheetShowAlert: Bool = false
    
    
    
    static var previews: some View {
        DataSpreadsheetView(numberOfMeters: $numberOfMeters, selectedRodSize: $selectedRodSize, showSpreadsheet: $showSpreadsheet, dataSpreadsheetShowAlert: $dataSpreadsheetShowAlert, firstRodSize: $firstRodSize)
    }
}
