//
//  MainSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 19.09.2023.
//

import SwiftUI

struct MainSpreadsheetView: View {
    @State var viewModelGraph = GraphViewModel()
    @State var viewModel = SpreadsheetViewModel()
    
    var body: some View {
        VStack {
            if viewModel.showSpreadsheet {
                if viewModel.showGraph {
                    // Display the SpreadsheetGraphView if showGraph is true
                    SpreadsheetGraphView(viewModel: viewModelGraph)
                } else {
                    // Display the SpreadsheetView if showGraph is false
                    SpreadsheetView(viewModel: viewModel)
                }
            } else {
                // Display the DataSpreadsheetView if showSpreadsheet is false
                DataSpreadsheetView(viewModel: viewModel)
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
