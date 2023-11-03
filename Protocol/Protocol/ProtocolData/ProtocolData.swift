//
//  ProtocolData.swift
//  Protocol
//
//  Created by Alex Serban on 10.10.2023.
//

import Foundation
import SwiftUI
import Combine
import Observation

@Observable
class ProtocolData {
    
    // Published properties to store various data
    var constructor: String = ""
    var firstRodSize: String = ""
    var userEnteredValue: String = ""
    var weekshot: String = ""
    var area: String = ""
    var street: String = ""
    var pipeBundle: String = ""
    var totalPipes: String = ""
    var drillLength: String = ""
    var pilotOperator: String = ""
    var drillingRigOperator: String = ""
    var supervisor: String = ""
    var entryPitCoordinates: String = ""
    var exitPitCoordinates: String = ""
    var numberOfMeters = ""
    
    var showSpreadsheet: Bool = false // Control displaying the spreadsheet
    var isTableFullyCompleted: Bool = false // Control table completion status
    var spreadsheetShowAlert: Bool = false // Control spreadsheet-related alerts
    var dataSpreadsheetShowAlert: Bool = false // Control data spreadsheet-related alerts
    var showGraph: Bool = false // Control displaying the graph
    
    var columnValues: [Double] = [] // Store column values for graph
    var currentDate: Date = Date() // Store the current date
    var selectedRodSize: RodSize = .halfMeter // Store the selected rod size
    
    var numberOfColumns: Int  = 4 // Number of columns in the table
    var numberOfRowsCalculated: Int = 0 // Number of calculated rows
    var xAxisValues: Int = 0 // X-axis values for the graph
    
    var firstEntryImage: UIImage? // First entry image
    var secondEntryImage: UIImage? // Second entry image
    var firstExitImage: UIImage? // First exit image
    var secondExitImage: UIImage? // Second exit image
    var contractorSignature: UIImage? // Contractor's signature
    
    var pdfFileURL: URL?
    
    // Define an array of strings for the first column of the spreadsheet
    var firstColumn = ["Constructor", "Date (dd/mm/yy)", "Week-shot", "Area", "Street", "Pipe bundle", "Total number of pipes", "Drill length", "Pilot operator", "Drilling rig operator", "Supervisor", "Entry pit coordinates", "Exit pit coordinates", "Contractor signature"]
    
    // Define an array to store cell values and images for the table
    var cellValues: [[CellModel]] = Array(repeating: [CellModel(text: "", image: nil), CellModel(text: "", image: nil)], count: 16)
    var cellValuesString: [[String]] = [[]]
    
    // Define an array to control image visibility in the table
    var showImage = Array(repeating: false, count: 16)
    
    // Shared instance of ProtocolData for data sharing
    static var sharedData = ProtocolData()
}

// Define a struct to represent cell data with text and image
struct CellModel {
    var text: String
    var image: UIImage?
}

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
