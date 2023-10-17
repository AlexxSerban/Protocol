//
//  SpreadsheetViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 22.09.2023.
//

import Foundation
import SwiftUI

class SpreadsheetViewModel: ObservableObject {
    
    // Check if the table is fully completed
    func checkTableCompletion(numberOfRowsCalculated: Int, numberOfColumns: Int, cellValues: [[String]]) -> Bool {
        var isCompleted = true
        
        for row in 0..<numberOfRowsCalculated {
            for column in 0..<numberOfColumns - 1 {
                // Check if any cell is empty
                if cellValues[row][column].isEmpty {
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
}
