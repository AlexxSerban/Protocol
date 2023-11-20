//
//  ProtocolPDFViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 18.10.2023.
//

import Foundation
import SwiftUI
import PDFKit
import Observation

@Observable
class ProtocolPDFViewModel {
    
    var protocolData = ProtocolData.sharedData
    var showShareSheet: Bool = false
    var nextToEmail: Bool = false
    var generatedImage: Image?
    
    @MainActor
    func exportPDF() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let formattedDate = DateFormatter().string(from: Date()) 
        let renderedUrl = documentDirectory.appending(path: "Protocol-\(formattedDate)-\(protocolData.weekshot).pdf")

        let renderer = ImageRenderer(content: ProtocolView())
        renderer.scale = UIScreen.main.scale

        renderer.render { size, renderer in
            var mediaBox = CGRect(origin: .zero,
                                   size: CGSize(width: size.width + 100, height: size.height + 100))
            guard let consumer = CGDataConsumer(url: renderedUrl as CFURL),
                  let pdfContext = CGContext(consumer: consumer,
                                              mediaBox: &mediaBox, nil)
            else {
                return
            }

            pdfContext.beginPDFPage(nil)
            pdfContext.translateBy(x: mediaBox.size.width / 2 - size.width / 2,
                                   y: mediaBox.size.height / 2 - size.height / 2)
            renderer(pdfContext)
            pdfContext.endPDFPage()
            pdfContext.closePDF()
        }

        protocolData.pdfFileURL = renderedUrl
        showShareSheet.toggle()
    }

    
}


