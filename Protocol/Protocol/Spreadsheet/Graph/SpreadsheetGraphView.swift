//
//  SpreadsheetGraphView.swift
//  Protocol
//
//  Created by Alex Serban on 26.09.2023.
//

import SwiftUI
import Charts

struct SpreadsheetGraphView: View {
    
    @State var viewModel: GraphViewModel = GraphViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
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
                HStack {
                    Spacer()
                    Button {
                        viewModel.nextToExitPhoto.toggle()
                    } label: {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("ColorBox"))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.nextToExitPhoto) {
                ExitImagesView()
            }
        }
        .onAppear {
            viewModel.updateXAxisValues()
        }
    }
}

struct SpreadsheetGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SpreadsheetGraphView()
    }
}
