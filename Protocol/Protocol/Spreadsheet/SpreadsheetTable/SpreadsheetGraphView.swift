//
//  SpreadsheetGraphView.swift
//  Protocol
//
//  Created by Alex Serban on 26.09.2023.
//

import SwiftUI
import Charts

struct SpreadsheetGraphView: View {
    
    // Bindings for various UI and data properties
    @Binding var cellValues: [[String]]
    @Binding var numberOfRowsCalculated: Int
    @Binding var xAxisValues: Int
    @State var nextToExitPhoto: Bool = false
    
    // A computed property to sort cell values based on depth (column 1)
    var sortedCellValues: [[String]] {
        return cellValues.sorted { $0[1] < $1[1] }
    }
    
    // Total number of rows
    var totalRows: Int {
        return cellValues.count
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Line Chart")
                    .font(.title)
                    .padding()
                
                VStack {
                    Chart {
                        // Create LineMark and PointMark elements for each data point
                        ForEach(0..<totalRows, id: \.self) { index in
                            LineMark(
                                x: .value("Rod (Nr.)", index.advanced(by: 1)),
                                y: .value("Depth (cm)", Double(cellValues[index][1]) ?? 0.0)
                            )
                            PointMark(
                                x: .value("Rod (Nr.)", index.advanced(by: 1)),
                                y: .value("Depth (cm)", Double(cellValues[index][1]) ?? 0.0)
                            )
                        }
                    }
                    .chartYScale(domain: [xAxisValues, 0])
                    .chartXScale(domain: [0, numberOfRowsCalculated + 1])
                    .aspectRatio(1, contentMode: .fit)
                    .chartYAxis {
                        AxisMarks(position: .leading, values: .automatic(desiredCount: numberOfRowsCalculated))
                    }
                    .chartXAxis {
                        AxisMarks(position: .top, values: .automatic(desiredCount: xAxisValues)) { _ in
                            AxisValueLabel(anchor: .center)
                            AxisGridLine()
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    HStack {
                        Spacer()
                        Button {
                            nextToExitPhoto.toggle()
                        } label: {
                            Text("Next")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .padding()
            .navigationDestination(isPresented: $nextToExitPhoto) {
                ExitImagesView()
            }
        }
        .onAppear {
            updateXAxisValues()
        }
    }
    
    // Function to update xAxisValues
    func updateXAxisValues() {
        if let maxColumn2Value = cellValues.map({ Double($0[1]) ?? 0.0 }).max() {
            xAxisValues = Int(maxColumn2Value) + 30
        } else {
            xAxisValues = 250
        }
    }
}

// Preview for testing
struct SpreadsheetGraphView_Previews: PreviewProvider {
    
    @State static var numberOfRowsCalculated: Int = 0
    @State static var cellValues: [[String]] = []
    @State static var xAxisValues: Int = 250
    
    static var previews: some View {
        SpreadsheetGraphView(cellValues: $cellValues, numberOfRowsCalculated: $numberOfRowsCalculated, xAxisValues: $xAxisValues)
    }
}
