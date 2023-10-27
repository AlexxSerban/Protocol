//
//  SpreadsheetViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 22.09.2023.
//

import Foundation
import SwiftUI
import Observation

@Observable
class SpreadsheetViewModel {
    
    var protocolData = ProtocolData.sharedData
    var nextToExitPhoto: Bool = false
    var showSpreadsheet: Bool = false
    var dataSpreadsheetShowAlert: Bool = false
    var isTableFullyCompleted: Bool = false
    var spreadsheetShowAlert: Bool = false
    var showGraph: Bool = false
    
    
    // Check if the table is fully completed
    func checkTableCompletion() -> Bool {
        var isCompleted = true
        
        for row in 0..<protocolData.numberOfRowsCalculated {
            for column in 0..<protocolData.numberOfColumns - 1 {
                // Check if any cell is empty
                if protocolData.cellValuesString[row][column].isEmpty {
                    isCompleted = false
                    break
                }
            }
            if !isCompleted {
                break
            }
        }
        return isCompleted
    }
    
    // Generate a random value within a range (used for testing)
    func generateRandomValue() -> Float {
        return Float.random(in: 90...210)
    }
    
    // Generate increasing values for a specific row (for testing)
    func generateIncreasingValues(forRow row: Int) -> Float {
        let minValue: Float = -20.0
        let step: Float = 0.8 // Adjust the step to get appropriate values
        
        // Calculate the value based on the current row
        return minValue + Float(row) * step
    }
    
    func generateTableContent() {
        // Get the selected rod size in meters from a model.
        let rodSizeInMeters = protocolData.selectedRodSize.metersValue
        
        // Check if the input value for the number of meters is valid and greater than 0.
        if let metersValue = Double(protocolData.numberOfMeters), metersValue > 0 {
            // Calculate the number of rows needed to cover the input meters.
            protocolData.numberOfRowsCalculated = Int(ceil(metersValue / (Double(rodSizeInMeters))))
        } else {
            // If the value for the number of meters is not valid or <= 0, set the number of rows to 0.
            protocolData.numberOfRowsCalculated = 0
        }
        
        // Initialize the cell values matrix with empty rows and columns.
        protocolData.cellValuesString = Array(repeating: Array(repeating: "", count: protocolData.numberOfColumns), count: protocolData.numberOfRowsCalculated)
        
        // Check if there is at least one row in the cell values matrix.
        if protocolData.numberOfRowsCalculated > 0 {
            // Calculate the difference between the selected rod size and the first rod size in the model, then format it as a string.
            let difference = protocolData.selectedRodSize.metersValue - (protocolData.firstRodSize as NSString).floatValue
            protocolData.cellValuesString[0][0] = String(format: "%.2f", difference)
            
            // Calculate the cumulative length of rods for the other rows and format the values as strings.
            var cumulativeLength = difference
            for row in 1..<protocolData.numberOfRowsCalculated - 1{
                cumulativeLength += rodSizeInMeters
                protocolData.cellValuesString[row][0] = String(format: "%.2f", cumulativeLength)
            }
            
            // Generate random values for column 1
            for row in 0..<protocolData.numberOfRowsCalculated {
                protocolData.cellValuesString[row][1] = String(format: "%.2f", generateRandomValue())
            }
            
            // Generate increasing values for column 2
            for row in 0..<protocolData.numberOfRowsCalculated {
                protocolData.cellValuesString[row][2] = String(format: "%.2f", generateIncreasingValues(forRow: row))
            }
            
            // Add "first partial rod" to the last cell in the first row (in column with index 0).
            if protocolData.numberOfColumns > 0 {
                protocolData.cellValuesString[0][protocolData.numberOfColumns - 1] = "first partial rod"
            }
            
            // Add "last partial rod" to the last cell in the last row and last column (if there is at least one row and one column).
            if protocolData.numberOfRowsCalculated > 0 && protocolData.numberOfColumns > 0 {
                protocolData.cellValuesString[protocolData.numberOfRowsCalculated - 1][protocolData.numberOfColumns - 1] = "last partial rod"
            }
        }
    }
    
    
}



