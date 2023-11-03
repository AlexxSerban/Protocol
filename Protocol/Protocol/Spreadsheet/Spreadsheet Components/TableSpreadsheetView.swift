//
//  TableSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 23.10.2023.
//

import SwiftUI

struct TableSpreadsheetView: View {
    
    @State var viewModel: SpreadsheetViewModel = SpreadsheetViewModel()
    
    var body: some View {
        
        VStack {
            
            Text("HDD DIAGRAM")
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.mint)
                .border(Color.black, width: 1)
                .padding()
            
            // Header row for the table
            HStack(spacing: 0) {
                Text("Rod No.")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(8)
                Divider()
                    .background(Color.black)
                
                Text("Length (m)")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(8)
                Divider()
                    .background(Color.black)
                
                Text("Depth (cm)")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(8)
                Divider()
                    .background(Color.black)
                
                Text("Pitch(%)")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(8)
                Divider()
                    .background(Color.black)
                
                Text("Observations")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(8)
                
            }
            .background(Color.gray.opacity(0.5))
            .border(Color.black, width: 1)
            
            ForEach(0..<viewModel.protocolData.numberOfRowsCalculated, id: \.self) { row in
                HStack(spacing: 0) {
                    Text("\(row)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(8)
                        .border(Color.black, width: 1)
                    ForEach(0..<viewModel.protocolData.numberOfColumns, id: \.self) { column in
                        Text(viewModel.protocolData.cellValuesString[row][column])
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(8)
                            .border(Color.black, width: 1)
                    }
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
    
    static var previews: some View {
        TableSpreadsheetView()
    }
}
