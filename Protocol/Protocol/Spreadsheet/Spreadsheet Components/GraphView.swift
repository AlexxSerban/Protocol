//
//  GraphView.swift
//  Protocol
//
//  Created by Alex Serban on 23.10.2023.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @State var viewModel: GraphViewModel = GraphViewModel()
    
    var body: some View {
            VStack{
                VStack {
                    Text("Line Chart")
                        .font(.title)
                        .padding()
                    
                    VStack {
                        Chart {
                            ForEach(0..<viewModel.totalRows, id: \.self) { index in
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
    //                    .aspectRatio(contentMode: .fit)
                        .chartYAxis {
                            AxisMarks(position: .leading, values: .automatic(desiredCount: viewModel.protocolData.numberOfRowsCalculated))
                        }
                        .chartXAxis {
                            AxisMarks(position: .top, values: .automatic(desiredCount: viewModel.protocolData.xAxisValues)) { _ in
                                AxisValueLabel(anchor: .center)
                                AxisGridLine()
                            }
                        }
//                        .frame(maxHeight: .infinity)
                        .frame(width: 750, height: 700)
                    }
                    .padding()
                    .frame(maxWidth: .infinity ,maxHeight: .infinity)
                }
                .frame(maxHeight: .infinity)
            }
        .onAppear {
            viewModel.updateXAxisValues()
        }
    }
    
    
}

struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        GraphView()
    }
}
