//
//  GraphView.swift
//  Protocol
//
//  Created by Alex Serban on 23.10.2023.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @State var viewModel: GraphViewModel
    
    // A computed property to sort cell values based on depth (column 1)
    var sortedCellValues: [[String]] {
        return viewModel.protocolData.cellValuesString.sorted { $0[1] < $1[1] }
    }
    
    // Total number of rows
    var totalRows: Int {
        return viewModel.protocolData.cellValuesString.count
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
                                y: .value("Depth (cm)", Double(viewModel.protocolData.cellValuesString[index][1]) ?? 0.0)
                            )
                            PointMark(
                                x: .value("Rod (Nr.)", index.advanced(by: 1)),
                                y: .value("Depth (cm)", Double(viewModel.protocolData.cellValuesString[index][1]) ?? 0.0)
                            )
                        }
                    }
                    .chartYScale(domain: [viewModel.protocolData.xAxisValues, 0])
                    .chartXScale(domain: [0, viewModel.protocolData.numberOfRowsCalculated + 1])
                    .aspectRatio(1, contentMode: .fit)
                    .chartYAxis {
                        AxisMarks(position: .leading, values: .automatic(desiredCount: viewModel.protocolData.numberOfRowsCalculated))
                    }
                    .chartXAxis {
                        AxisMarks(position: .top, values: .automatic(desiredCount: viewModel.protocolData.xAxisValues)) { _ in
                            AxisValueLabel(anchor: .center)
                            AxisGridLine()
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.updateXAxisValues()
        }
    }
    
    
}

struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        GraphView(viewModel: GraphViewModel())
    }
}
