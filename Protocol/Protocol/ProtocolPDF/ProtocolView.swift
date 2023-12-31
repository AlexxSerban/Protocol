//
//  PDFView.swift
//  Protocol
//
//  Created by Alex Serban on 28.10.2023.
//

import SwiftUI

struct ProtocolView: View {
    @State var viewModel = ProtocolPDFViewModel()
    @State var viewModelSpreadsheet = SpreadsheetViewModel()
    @State var viewModelGraph = GraphViewModel()
    
    var body: some View {
        VStack {
            HeaderSpreadsheetView()
                .frame(maxHeight: .infinity)
            
            TableSpreadsheetView(viewModel: viewModelSpreadsheet)
                .frame(maxHeight: .infinity)
            
            GraphView(viewModel: viewModelGraph)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    ProtocolView()
}
