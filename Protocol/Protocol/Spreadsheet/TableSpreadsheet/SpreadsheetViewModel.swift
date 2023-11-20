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
    
    func checkTableCompletion() -> Bool {
        var isCompleted = true
        
        for row in 0..<protocolData.numberOfRowsCalculated {
            for column in 0..<protocolData.numberOfColumns - 1 {
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
    
    func updateButtonAction(viewModel: SpreadsheetViewModel) {
        if let enteredValue = Float(viewModel.protocolData.userEnteredValue) {
            let lastRow = viewModel.protocolData.numberOfRowsCalculated - 1
            let difference = Float(viewModel.protocolData.selectedRodSize.metersValue) - enteredValue
            viewModel.protocolData.cellValuesString[lastRow][0] = String(format: "%.2f", difference)
        }
    }

    func generateTableContent() {
        let rodSizeInMeters = protocolData.selectedRodSize.metersValue
        if let metersValue = Double(protocolData.numberOfMeters), metersValue > 0 {
            protocolData.numberOfRowsCalculated = Int(ceil(metersValue / (Double(rodSizeInMeters))))
        } else {
            protocolData.numberOfRowsCalculated = 0
        }
        
        protocolData.cellValuesString = Array(repeating: Array(repeating: "", count: protocolData.numberOfColumns), count: protocolData.numberOfRowsCalculated)
        
        if protocolData.numberOfRowsCalculated > 0 {
            let difference = protocolData.selectedRodSize.metersValue - (protocolData.firstRodSize as NSString).floatValue
            protocolData.cellValuesString[0][0] = String(format: "%.2f", difference)
            
            var cumulativeLength = difference
            for row in 1..<protocolData.numberOfRowsCalculated - 1{
                cumulativeLength += rodSizeInMeters
                protocolData.cellValuesString[row][0] = String(format: "%.2f", cumulativeLength)
            }
            
            if protocolData.numberOfColumns > 0 {
                protocolData.cellValuesString[0][protocolData.numberOfColumns - 1] = "first partial rod"
            }
            
            if protocolData.numberOfRowsCalculated > 0 && protocolData.numberOfColumns > 0 {
                protocolData.cellValuesString[protocolData.numberOfRowsCalculated - 1][protocolData.numberOfColumns - 1] = "last partial rod"
            }
            
        }
    }
}



