//
//  MainHeaderSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 09.10.2023.
//

import SwiftUI

struct MainHeaderSpreadsheetView: View {
    
    // Create an instance of FirmSpreadsheetViewModel as a state object
    @State var viewModel = HeaderSpreadsheetViewModel()
    
    var body: some View {
        VStack {
            if viewModel.showSpreadsheetFirm {
                HeaderDetailsSpreadsheetView(viewModel: viewModel)
            }
            else {
                HeaderDataSpreadsheetView(viewModel: viewModel)
            }
        }
    }
}

// A preview block for testing the MainFirmSpreadsheetView
struct MainFirmSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderSpreadsheetView()
    }
}
