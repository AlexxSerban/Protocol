//
//  MainFirmSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 09.10.2023.
//

import SwiftUI

struct MainFirmSpreadsheetView: View {
    
    // Create an instance of FirmSpreadsheetViewModel as a state object
    @StateObject var viewModel = FirmSpreadsheetViewModel()
    
    // Create a state variable to control whether to show the spreadsheet or not
    @State var showSpreadsheet: Bool = false
    
    var body: some View {
        VStack {
            if showSpreadsheet {
                // If showSpreadsheet is true, display the FirmDetailsSpreadsheetView
                FirmDetailsSpreadsheetView(
                    cellValues: $viewModel.model.cellValues,
                    firstColumn: $viewModel.model.firstColumn,
                    constructor: $viewModel.model.constructor,
                    currentDate: $viewModel.model.currentDate,
                    weekshot: $viewModel.model.weekshot,
                    area: $viewModel.model.area,
                    street: $viewModel.model.street,
                    pipeBundle: $viewModel.model.pipeBundle,
                    drillLength: $viewModel.model.drillLength,
                    pilotOperator: $viewModel.model.pilotOperator,
                    drillingRigOperator: $viewModel.model.drillingRigOperator,
                    supervisor: $viewModel.model.supervisor,
                    entryPitCoordinates: $viewModel.model.entryPitCoordinates,
                    exitPitCoordinates: $viewModel.model.exitPitCoordinates,
                    contractorSignature: $viewModel.model.contractorSignature
                )
                
            }
            else {
                // If showSpreadsheet is false, display the FirmDataSpreadsheetView
                FirmDataSpreadsheetView(
                    constructor: $viewModel.model.constructor,
                    weekshot: $viewModel.model.weekshot,
                    area: $viewModel.model.area,
                    street: $viewModel.model.street,
                    pipeBundle: $viewModel.model.pipeBundle,
                    drillLength: $viewModel.model.drillLength,
                    pilotOperator: $viewModel.model.pilotOperator,
                    drillingRigOperator: $viewModel.model.drillingRigOperator,
                    supervisor: $viewModel.model.supervisor,
                    entryPitCoordinates: $viewModel.model.entryPitCoordinates,
                    exitPitCoordinates: $viewModel.model.exitPitCoordinates,
                    contractorSignature: $viewModel.model.contractorSignature,
                    showSpreadsheet: $showSpreadsheet
                )
            }
        }
    }
}

// A preview block for testing the MainFirmSpreadsheetView
struct MainFirmSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        MainFirmSpreadsheetView()
    }
}
