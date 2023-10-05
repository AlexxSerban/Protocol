//
//  SpreadshhetGraph.swift
//  Protocol
//
//  Created by Alex Serban on 26.09.2023.
//

import SwiftUI
import Charts


struct SpreadsheetGraphView: View {
    
    @Binding var cellValues: [[String]]
    @Binding var numberOfRowsCalculated: Int
    var xAxisValues = 250
    
    
    var sortedCellValues: [[String]] {
        return cellValues.sorted { $0[1] < $1[1] }
    }
    
    var totalRows: Int {
        return cellValues.count
    }
    
    var body: some View {
        VStack {
            Text("Grafic cu Linii")
                .font(.title)
                .padding()
            
            VStack {
                Chart {
                    ForEach(0..<totalRows, id: \.self) { index in
                        LineMark (
                            x: .value("Rod (Nr.)", index.advanced(by: 1)),
                            y: .value("Adâncime (cm)", Double(cellValues[index][1]) ?? 0.0)
                        )
                        PointMark (
                            x: .value("Rod (Nr.)", index.advanced(by: 1)),
                            y: .value("Adâncime (cm)", Double(cellValues[index][1]) ?? 0.0)
                            
                        )
                        
                        .annotation {
                            Circle()
                                .fill(Color.blue.opacity(0.5))
                                .frame(width: 55, height: 55)
                                .overlay(Text(cellValues[index][1]))
                        }
                        
                        
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .chartYAxis {
                    AxisMarks(position: .leading ,values: .automatic(desiredCount: numberOfRowsCalculated))
                }
                .chartXAxis {
                    AxisMarks(position: .bottom, values: .automatic(desiredCount: xAxisValues)) { _ in
                        AxisValueLabel( anchor: .center)
                    }
                }
                
                .frame(maxHeight: .infinity)
            }
            .padding()
        }
        .padding()
    }
}

struct SpreadsheetGraphView_Previews: PreviewProvider {
    
    @State static var numberOfRowsCalculated: Int = 0
    @State static var cellValues: [[String]] = []
    
    static var previews: some View {
        SpreadsheetGraphView(cellValues: $cellValues, numberOfRowsCalculated: $numberOfRowsCalculated)
    }
}

