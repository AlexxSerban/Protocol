//
//  SpreadsheetViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 22.09.2023.
//

import Foundation

import SwiftUI

class SpreadsheetViewModel: ObservableObject {
    
    func checkTableCompletion(numberOfRowsCalculated: Int, numberOfColumns: Int, cellValues: [[String]]) -> Bool {
        var isCompleted = true
        for row in 0..<numberOfRowsCalculated {
            for column in 0..<numberOfColumns - 1{
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
}
