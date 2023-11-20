//
//  GraphViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 25.10.2023.
//

import Foundation
import Observation

@Observable
class GraphViewModel {
    
    var protocolData = ProtocolData.sharedData
    var nextToExitPhoto: Bool = false
    var sortedCellValues: [[String]] {
        return protocolData.cellValuesString.sorted { $0[1] < $1[1] }
    }
    
    var totalRows: Int {
        return protocolData.cellValuesString.count
    }
    
    func updateXAxisValues() {
        if let maxColumn2Value = protocolData.cellValuesString.map({ Double($0[1]) ?? 0.0 }).max() {
            protocolData.xAxisValues = Int(maxColumn2Value) + 30
        } else {
            protocolData.xAxisValues = 250
        }
    }
}
