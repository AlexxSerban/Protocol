//
//  SpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 15.09.2023.
//

import SwiftUI
import Foundation

struct SpreadsheetView: View {
    
    @Binding var numberOfColumns: Int
    @Binding var numberOfRowsCalculated: Int
    @Binding var numberOfMeters: String
    @Binding var selectedRodSize: RodSize
    @Binding var cellValues: [[String]]
    @Binding var firstRodSize: String
    @Binding var userEnteredValue: String
    @Binding var isTableFullyCompleted: Bool
    @Binding var spreadsheetShowAlert: Bool
    @Binding var showGraph: Bool
    
    @State var viewModel: SpreadsheetViewModel
    
    var body: some View {
        
        VStack(spacing: 30) {

            List {
                HStack(spacing: 0) {
                    Text("HDD DIAGRAM")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.mint)
                }
                .border(Color.black, width: 1)
                
                HStack(spacing: 0) {
                    Divider()
                    Text("Rod No.")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Length (m)")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Depth (cm)")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Pitch(%)")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Observations")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(Color.gray.opacity(0.5))
                .border(Color.black, width: 1)
                
                ForEach(0..<numberOfRowsCalculated, id: \.self) { row in
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1)
                        Text("\(row)")
                            .frame(minWidth: 0, maxWidth: .infinity)
                        ForEach(0..<numberOfColumns, id: \.self) { column in
                            Divider()
                            if row == 0 && column == 0 {
                                let difference = selectedRodSize.metersValue - (firstRodSize as NSString).floatValue
                                TextField(String(format: "%.2f", difference), text: $cellValues[row][column])
                                    .multilineTextAlignment(.center)
                            } else {
                                TextField("", text: $cellValues[row][column])
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .border(Color.black, width: 1)
            }
            
            HStack(spacing: 16) {
                TextField("Enter the number of meters for the last rod", text: $userEnteredValue)
                    .frame(width: 350)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: {
                    if let enteredValue = Float(userEnteredValue) {
                        let lastRow = numberOfRowsCalculated - 1
                        let difference = Float(selectedRodSize.metersValue) - enteredValue
                        cellValues[lastRow][0] = String(format: "%.2f", difference)
                    }
                }) {
                    Text("Update")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    if viewModel.checkTableCompletion(numberOfRowsCalculated: numberOfRowsCalculated, numberOfColumns: numberOfColumns, cellValues: cellValues) {
                        // Tabelul este complet
                        showGraph = true
                        print("Tabelul este complet. Execută acțiunea Next.")
                    } else {
                        // Tabelul nu este complet, arătați alerta
                        spreadsheetShowAlert = true
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
            .alert(isPresented: $spreadsheetShowAlert) {
                Alert(
                    title: Text("Incomplete Table"),
                    message: Text("Please complete all fields in the table before proceeding."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
        .onAppear {
            // Get the selected rod size in meters from a model.
            let rodSizeInMeters = selectedRodSize.metersValue
            
            // Check if the input value for the number of meters is valid and greater than 0.
            if let metersValue = Double(numberOfMeters), metersValue > 0 {
                // Calculate the number of rows needed to cover the input meters.
                numberOfRowsCalculated = Int(ceil(metersValue / (Double(rodSizeInMeters))))
            } else {
                // If the value for the number of meters is not valid or <= 0, set the number of rows to 0.
                numberOfRowsCalculated = 0
            }
            
            // Initialize the cell values matrix with empty rows and columns.
            cellValues = Array(repeating: Array(repeating: "", count: numberOfColumns), count: numberOfRowsCalculated)
            
            // Check if there is at least one row in the cell values matrix.
            if numberOfRowsCalculated > 0 {
                // Calculate the difference between the selected rod size and the first rod size in the model, then format it as a string.
                let difference = selectedRodSize.metersValue - (firstRodSize as NSString).floatValue
                cellValues[0][0] = String(format: "%.2f", difference)
                
                // Calculate the cumulative length of rods for the other rows and format the values as strings.
                var cumulativeLength = difference
                for row in 1..<numberOfRowsCalculated - 1{
                    cumulativeLength += rodSizeInMeters
                    cellValues[row][0] = String(format: "%.2f", cumulativeLength)
                }
                
                // Generate random values for column 1
                    for row in 0..<numberOfRowsCalculated {
                        cellValues[row][1] = String(format: "%.2f", generateRandomValue())
                    }
                
                // Generate increasing values for column 2
                for row in 0..<numberOfRowsCalculated {
                        cellValues[row][2] = String(format: "%.2f", generateIncreasingValues(forRow: row))
                    }
                
                // Add "first partial rod" to the last cell in the first row (in column with index 0).
                if numberOfColumns > 0 {
                    cellValues[0][numberOfColumns - 1] = "first partial rod"
                }
                
                // Add "last partial rod" to the last cell in the last row and last column (if there is at least one row and one column).
                if numberOfRowsCalculated > 0 && numberOfColumns > 0 {
                    cellValues[numberOfRowsCalculated - 1][numberOfColumns - 1] = "last partial rod"
                }
            }
            
            // Display debug information in the console.
            print("setupSpreadsheetData() called")
            print("numberOfRowsCalculated: \(numberOfRowsCalculated)")
            print("cellValues: \(cellValues)")
        }
    }
    
    func generateRandomValue() -> Float {
        return Float.random(in: 90...210)
    }
    func generateIncreasingValues(forRow row: Int) -> Float {
        // Calculează valoarea în funcție de rândul curent
        let minValue: Float = -20.0
        let step: Float = 0.8 // Ajustează pasul pentru a obține valori corespunzătoare
        return minValue + Float(row) * step
    }


}

struct SpreadsheetView_Previews: PreviewProvider {
    @State static var selectedRodSize: RodSize = .halfMeter
    @State static var numberOfMeters: String = "100"
    @State static var firstRodSize: String = "3.05"
    @State static var userEnteredValue: String = "1.2"
    @State static var numberOfColumns: Int = 4
    @State static var numberOfRowsCalculated: Int = 0
    @State static var cellValues: [[String]] = []
    @State static var isTableFullyCompleted: Bool = false
    @State static var spreadsheetShowAlert: Bool = false
    @State static var showGraph: Bool = false
    @State static var viewModel: SpreadsheetViewModel = SpreadsheetViewModel()
    
    
    static var previews: some View {
        SpreadsheetView(numberOfColumns: $numberOfColumns, numberOfRowsCalculated: $numberOfRowsCalculated, numberOfMeters: $numberOfMeters, selectedRodSize: $selectedRodSize, cellValues: $cellValues, firstRodSize: $firstRodSize, userEnteredValue: $userEnteredValue, isTableFullyCompleted: $isTableFullyCompleted, spreadsheetShowAlert: $spreadsheetShowAlert, showGraph: $showGraph, viewModel: viewModel)
    }
}

