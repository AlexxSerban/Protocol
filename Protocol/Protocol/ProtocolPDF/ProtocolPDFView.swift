//
//  ProtocolPDFView.swift
//  Protocol
//
//  Created by Alex Serban on 18.10.2023.
//

import SwiftUI
import PDFKit


struct ProtocolPDFView: View {
    @State var viewModel = ProtocolPDFViewModel()
    @State var viewModelSpreadsheet = SpreadsheetViewModel()
    @State var viewModelGraph = GraphViewModel()
    
    
    var body: some View {
        VStack {
            VStack{
                HeaderSpreadsheetView()
                    .frame(maxHeight: .infinity)
                
                TableSpreadsheetView(viewModel: viewModelSpreadsheet)
                    .frame(maxHeight: .infinity)
                
//                GraphView(viewModel: viewModelGraph)
//                    .frame(maxHeight: .infinity)
            }

            Button {
                _ = viewModel.render(self)
            } label: {
                Label("Hehe", systemImage: "figure.core.training")
            }

        }
        .padding()
        .sheet(isPresented: $viewModel.showShareSheet) {
            viewModel.PDFUrl = nil
        } content: {
            if let PDFUrl = viewModel.PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }
    }
}

#Preview {
    ProtocolPDFView()
}

//MARK: Share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
