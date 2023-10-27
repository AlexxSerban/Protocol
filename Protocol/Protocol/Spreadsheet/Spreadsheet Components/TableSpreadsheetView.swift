//
//  TableSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 23.10.2023.
//

import SwiftUI

struct TableSpreadsheetView: View {
    
    @State var viewModel: SpreadsheetViewModel
    
    var body: some View {
        
        VStack(spacing: 30) {

            List {
                HStack(spacing: 0) {
                    Text("HDD DIAGRAM")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.mint)
                }
                .border(Color.black, width: 1)
                
                // Header row for the table
                HStack(spacing: 0) {
                    Divider()
                    Text("Rod No.")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Length (m)")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Depth (cm)")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Pitch(%)")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Divider()
                    Text("Observations")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(Color.gray.opacity(0.5))
                .border(Color.black, width: 1)
                
                // Loop to display table rows
                ForEach(0..<viewModel.protocolData.numberOfRowsCalculated, id: \.self) { row in
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1)
                        Text("\(row)")
                            .frame(minWidth: 0, maxWidth: .infinity)
                        ForEach(0..<viewModel.protocolData.numberOfColumns, id: \.self) { column in
                            Divider()
                            if row == 0 && column == 0 {
                                let difference = viewModel.protocolData.selectedRodSize.metersValue - (viewModel.protocolData.firstRodSize as NSString).floatValue
                                TextField(String(format: "%.2f", difference), text: $viewModel.protocolData.cellValuesString[row][column])
                                    .multilineTextAlignment(.center)
                            } else {
                                TextField("", text: $viewModel.protocolData.cellValuesString[row][column])
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .border(Color.black, width: 1)
                .padding()
                .alert(isPresented: $viewModel.spreadsheetShowAlert) {
                    Alert(
                        title: Text("Incomplete Table"),
                        message: Text("Please complete all fields in the table before proceeding."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.generateTableContent()

        }
    }
}

struct SpreadsheetTableView_Previews: PreviewProvider {
    @State static var viewModel: SpreadsheetViewModel = SpreadsheetViewModel()
    
    static var previews: some View {
        TableSpreadsheetView(viewModel: viewModel)
    }
}
