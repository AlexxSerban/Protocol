//
//  ProtocolData.swift
//  Protocol
//
//  Created by Alex Serban on 10.10.2023.
//

import Foundation
import SwiftUI
import Combine

class ProtocolData: ObservableObject {
    // Published properties to store various data
    @Published var constructor: String = ""
    @Published var firstRodSize: String = ""
    @Published var userEnteredValue: String = ""
    @Published var weekshot: String = ""
    @Published var area: String = ""
    @Published var street: String = ""
    @Published var pipeBundle: String = ""
    @Published var drillLength: String = ""
    @Published var pilotOperator: String = ""
    @Published var drillingRigOperator: String = ""
    @Published var supervisor: String = ""
    @Published var entryPitCoordinates: String = ""
    @Published var exitPitCoordinates: String = ""
    @Published var numberOfMeters = ""
    
    @Published var showSpreadsheet: Bool = false // Control displaying the spreadsheet
    @Published var isTableFullyCompleted: Bool = false // Control table completion status
    @Published var spreadsheetShowAlert: Bool = false // Control spreadsheet-related alerts
    @Published var dataSpreadsheetShowAlert: Bool = false // Control data spreadsheet-related alerts
    @Published var showGraph: Bool = false // Control displaying the graph
    
    @Published var columnValues: [Double] = [] // Store column values for graph
    @Published var currentDate: Date = Date() // Store the current date
    @Published var selectedRodSize: RodSize = .halfMeter // Store the selected rod size
    
    @Published var numberOfColumns: Int  = 4 // Number of columns in the table
    @Published var numberOfRowsCalculated: Int = 0 // Number of calculated rows
    @Published var xAxisValues: Int = 0 // X-axis values for the graph
    
    @Published var firstEntryImage: UIImage? // First entry image
    @Published var secondEntryImage: UIImage? // Second entry image
    @Published var firstExitImage: UIImage? // First exit image
    @Published var secondExitImage: UIImage? // Second exit image
    @Published var contractorSignature: UIImage? // Contractor's signature

    // Define an array of strings for the first column of the spreadsheet
    @Published var firstColumn = ["Constructor", "Date (dd/mm/yy)", "Week-shot", "Area", "Street", "Pipe bundle 1", "Pipe bundle 2", "Pipe bundle 3", "Pipe bundle 4", "Drill length", "Pilot operator", "Drilling rig operator", "Supervisor", "Entry pit coordinates", "Exit pit coordinates", "Contractor signature"]

    // Define an array to store cell values and images for the table
    @Published var cellValues: [[CellModel]] = Array(repeating: [CellModel(text: "", image: nil), CellModel(text: "", image: nil)], count: 16)

    // Define an array to control image visibility in the table
    @Published var showImage = Array(repeating: false, count: 16)

    // Shared instance of ProtocolData for data sharing
    static var sharedData = ProtocolData()
}

// Define a struct to represent cell data with text and image
struct CellModel {
    var text: String
    var image: UIImage?
}
