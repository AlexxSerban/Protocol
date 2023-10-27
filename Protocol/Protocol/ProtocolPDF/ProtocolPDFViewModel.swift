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
    
    //MARK: PDF Properties
    //Share sheet Producing error that when using @State
    //Work Through Use @StateObject Instead
    var PDFUrl: URL?
    var showShareSheet: Bool = false
    var generatedImage: Image?
    
    
    @MainActor
    func render<Content: View>(_ content: Content) -> URL {
        let renderedUrl = URL.documentsDirectory.appending(path: "output.pdf")
        
        if let consumer = CGDataConsumer(url: renderedUrl as CFURL),
           let pdfContext = CGContext(consumer: consumer, mediaBox: nil, nil) {
            
            let renderer = ImageRenderer(content: content)
            renderer.render { size, renderer in
                let options: [CFString: Any] = [
                    kCGPDFContextMediaBox: CGRect(origin: .zero, size: size)
                ]
                
                pdfContext.beginPDFPage(options as CFDictionary)
                
                renderer(pdfContext)
                pdfContext.endPDFPage()
                pdfContext.closePDF()
            }
        }
        
        print("Saving PDF to \(renderedUrl.path())")
        
        return renderedUrl
    }
    
}


