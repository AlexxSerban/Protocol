//
//  FirmSpreadsheetModel.swift
//  Protocol
//
//  Created by Alex Serban on 10.10.2023.
//

import Foundation
import SwiftUI

class FirmSpreadsheetModel : ObservableObject {
    
    @Published var constructor: String = ""
    @Published var currentDate: Date = Date()
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
    @Published var contractorSignature: UIImage?
    @Published var firstColumn = ["Constructor", "Date (dd/mm/yy)", "Week-shot", "Area", "Street", "Pipe bundle 1", "Pipe bundle 2", "Pipe bundle 3", "Pipe bundle 4", "Drill length", "Pilot operator", "Drilling rig operator", "Supervisor", "Entry pit coordinates", "Exit pit coordinates", "Contractor signature"]
    
    @Published var cellValues = [[String]](repeating: ["", ""], count: 16)
    @Published var showImage = Array(repeating: false, count: 16)
}
