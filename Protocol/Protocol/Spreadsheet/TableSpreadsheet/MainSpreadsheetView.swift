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
                    SpreadsheetGraphView()
                } else {
                    SpreadsheetView(viewModel: viewModel)
                }
            } else {
                DataSpreadsheetView(viewModel: viewModel)
            }
        }
    }
}

struct MainSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        MainSpreadsheetView()
    }
}
