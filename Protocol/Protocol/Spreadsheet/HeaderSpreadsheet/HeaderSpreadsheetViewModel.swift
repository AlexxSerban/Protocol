//
//  HeaderSpreadsheetViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 10.10.2023.
//

import Foundation
import Observation

@Observable
class HeaderSpreadsheetViewModel {
    
    var protocolData = ProtocolData.sharedData
    var isDataComplete = false
    var isAlertPresented = false
    // Create a state variable to control whether to show the spreadsheet or not
    var showSpreadsheet: Bool = false
    var showSpreadsheetFirm: Bool = false
    var isImagePickerPresented = false
    var isDataCompleteForData = false
    var isAlertPresentedForData = false
    
    func initializeSpreadsheetFirm() {
        // Initialize the spreadsheet with data
        for row in 0..<protocolData.firstColumn.count {
            protocolData.cellValues[row][0].text = protocolData.firstColumn[row]
            protocolData.cellValues[row][1].text = ""
        }
        
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Constructor") ?? 0][1].text = protocolData.constructor
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: protocolData.currentDate)
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Date (dd/mm/yy)") ?? 1][1].text = dateString
        
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Week-shot") ?? 2][1].text = protocolData.weekshot
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Area") ?? 3][1].text = protocolData.area
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Street") ?? 4][1].text = protocolData.street
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Pipe bundle") ?? 5][1].text = protocolData.pipeBundle
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Total pipes") ?? 6][1].text = protocolData.totalPipes
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Drill length") ?? 7][1].text = protocolData.drillLength
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Pilot operator") ?? 8][1].text = protocolData.pilotOperator
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Drilling rig operator") ?? 9][1].text = protocolData.drillingRigOperator
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Supervisor") ?? 10][1].text = protocolData.supervisor
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Entry pit coordinates") ?? 11][1].text = protocolData.entryPitCoordinates
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Exit pit coordinates") ?? 12][1].text = protocolData.exitPitCoordinates
        protocolData.cellValues[protocolData.firstColumn.firstIndex(of: "Contractor signature") ?? 13][1].image = protocolData.contractorSignature
    }
    
    func checkCellValues() {
        // Check if all required fields are filled
        if !protocolData.cellValues[0][0].text.isEmpty &&
            !protocolData.cellValues[1][0].text.isEmpty &&
            !protocolData.cellValues[2][0].text.isEmpty &&
            !protocolData.cellValues[3][0].text.isEmpty &&
            !protocolData.cellValues[4][0].text.isEmpty &&
            !protocolData.cellValues[5][0].text.isEmpty &&
            !protocolData.cellValues[6][0].text.isEmpty &&
            !protocolData.cellValues[7][0].text.isEmpty &&
            !protocolData.cellValues[8][0].text.isEmpty &&
            !protocolData.cellValues[9][0].text.isEmpty &&
            !protocolData.cellValues[10][0].text.isEmpty &&
            !protocolData.cellValues[11][0].text.isEmpty &&
            !protocolData.cellValues[12][0].text.isEmpty &&
            !protocolData.cellValues[13][0].text.isEmpty &&
            
            protocolData.contractorSignature != nil {
            isDataComplete.toggle()
        } else {
            isAlertPresented.toggle()
        }
    }
    
    func checkFirmValues() {
        if !protocolData.constructor.isEmpty &&
            !protocolData.weekshot.isEmpty &&
            !protocolData.drillLength.isEmpty &&
            !protocolData.pilotOperator.isEmpty &&
            !protocolData.pipeBundle.isEmpty &&
            !protocolData.totalPipes.isEmpty &&
            !protocolData.drillingRigOperator.isEmpty &&
            !protocolData.supervisor.isEmpty &&
            protocolData.contractorSignature != nil
        {
            showSpreadsheetFirm = true
        } else {
            isAlertPresented.toggle()
        }
    }
}
