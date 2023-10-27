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
    
    
//    @MainActor 
//    func render() -> URL {
//            // 1: Render Hello World with some modifiers
//            let renderer = ImageRenderer(content:
//                ProtocolPDFView()
//            )
//
//            // 2: Save it to our documents directory
//            let url = URL.documentsDirectory.appending(path: "output.pdf")
//
//            // 3: Start the rendering process
//            renderer.render { size, context in
//                // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
//                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//
//                // 5: Create the CGContext for our PDF pages
//                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
//                    return
//                }
//
//                // 6: Start a new PDF page
//                pdf.beginPDFPage(nil)
//
//                // 7: Render the SwiftUI view data onto the page
//                context(pdf)
//
//                // 8: End the page and close the file
//                pdf.endPDFPage()
//                pdf.closePDF()
//            }
//
//            return url
//        }
// 
}


