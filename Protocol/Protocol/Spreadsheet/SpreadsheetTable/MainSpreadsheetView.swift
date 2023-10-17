//
//  MainSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 19.09.2023.
//

import SwiftUI

// Enumeration to represent different rod sizes
enum RodSize: String, CaseIterable, Identifiable {
    case halfMeter = "0.5 meters"
    case meter128288 = "1.28288 meters"
    case meter149352 = "1.49352 meters"
    case meter305 = "3.05 meters"
    case meter3 = "3 meters"
    case meter4572 = "4.572 meters"
    case meter91 = "9.1 meters"
    
    var id: Self { self }
    
    // A computed property to get the meters value for each rod size
    var metersValue: Float {
        switch self {
        case .halfMeter:
            return 0.5
        case .meter128288:
            return 1.28288
        case .meter149352:
            return 1.49352
        case .meter305:
            return 3.05
        case .meter3:
            return 3
        case .meter4572:
            return 4.572
        case .meter91:
            return 9.1
        }
    }
}


struct MainSpreadsheetView: View {
    // State variables to control the spreadsheet view
    @State var numberOfColumns = 4
    @State var numberOfRowsCalculated: Int = 0
    @State var showSpreadsheet = false
    @State var isTableFullyCompleted: Bool = false
    @State var spreadsheetShowAlert: Bool = false
    @State var dataSpreadsheetShowAlert: Bool = false
    @State var showGraph: Bool = false
    @State var cellValues: [[String]] = []
    @State var numberOfMeters = ""
    @State var selectedRodSize: RodSize = .halfMeter
    @State var firstRodSize: String = ""
    @State var userEnteredValue: String = ""
    @State var columnValues: [Double] = []
    @State var xAxisValues: Int = 0
    
    // ObservedObject for the SpreadsheetViewModel
    @ObservedObject var viewModel: SpreadsheetViewModel = SpreadsheetViewModel()

    var body: some View {
        VStack {
            if showSpreadsheet {
                if showGraph {
                    // Display the SpreadsheetGraphView if showGraph is true
                    SpreadsheetGraphView(cellValues: $cellValues, numberOfRowsCalculated: $numberOfRowsCalculated, xAxisValues: $xAxisValues)
                } else {
                    // Display the SpreadsheetView if showGraph is false
                    SpreadsheetView(
                        numberOfColumns: $numberOfColumns,
                        numberOfRowsCalculated: $numberOfRowsCalculated,
                        numberOfMeters: $numberOfMeters,
                        selectedRodSize: $selectedRodSize,
                        cellValues: $cellValues,
                        firstRodSize: $firstRodSize,
                        userEnteredValue: $userEnteredValue,
                        isTableFullyCompleted: $isTableFullyCompleted,
                        spreadsheetShowAlert: $spreadsheetShowAlert,
                        showGraph: $showGraph,
                        viewModel: viewModel
                    )
                }
            } else {
                // Display the DataSpreadsheetView if showSpreadsheet is false
                DataSpreadsheetView(
                    numberOfMeters: $numberOfMeters,
                    selectedRodSize: $selectedRodSize,
                    showSpreadsheet: $showSpreadsheet,
                    dataSpreadsheetShowAlert: $dataSpreadsheetShowAlert,
                    firstRodSize: $firstRodSize
                )
            }
        }
    }
}

// A preview block for testing the MainSpreadsheetView
struct MainSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        MainSpreadsheetView()
    }
}
