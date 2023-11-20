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
import MessageUI
import MobileCoreServices
import UniformTypeIdentifiers
import Observation
import PDFKit

@Observable
class ProtocolData {
    
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
    
    var showSpreadsheet: Bool = false
    var isTableFullyCompleted: Bool = false
    var spreadsheetShowAlert: Bool = false
    var dataSpreadsheetShowAlert: Bool = false
    var showGraph: Bool = false
    
    var columnValues: [Double] = []
    var currentDate: Date = Date()
    var selectedRodSize: RodSize = .halfMeter
    
    var numberOfColumns: Int  = 4
    var numberOfRowsCalculated: Int = 0
    var xAxisValues: Int = 0
    
    var firstEntryImage: UIImage?
    var secondEntryImage: UIImage?
    var firstExitImage: UIImage?
    var secondExitImage: UIImage?
    var contractorSignature: UIImage?
    
    var pdfFileURL: URL?
    
    var firstColumn = ["Constructor", "Date (dd/mm/yy)", "Week-shot", "Area", "Street", "Pipe bundle", "Total number of pipes", "Drill length", "Pilot operator", "Drilling rig operator", "Supervisor", "Entry pit coordinates", "Exit pit coordinates", "Contractor signature"]
    
    var cellValues: [[CellModel]] = Array(repeating: [CellModel(text: "", image: nil), CellModel(text: "", image: nil)], count: 16)
    var cellValuesString: [[String]] = [[]]
    
    var showImage = Array(repeating: false, count: 16)
    
    static var sharedData = ProtocolData()
}

struct CellModel {
    var text: String
    var image: UIImage?
}

enum RodSize: String, CaseIterable, Identifiable {
    case halfMeter = "0.5 meters"
    case meter128288 = "1.28288 meters"
    case meter149352 = "1.49352 meters"
    case meter305 = "3.05 meters"
    case meter3 = "3 meters"
    case meter4572 = "4.572 meters"
    case meter91 = "9.1 meters"
    
    var id: Self { self }
    
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
