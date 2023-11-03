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
    
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    ProtocolView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding()
                
                HStack {
                    Button {
                        viewModel.exportPDF()

                    } label: {
                        Text("Save PDF")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.nextToEmail.toggle()
                    } label: {
                        Text("Next")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                }
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.showShareSheet) {
            viewModel.PDFUrl = nil
        } content: {
            if let PDFUrl = viewModel.protocolData.pdfFileURL {
                ShareSheet(urls: [PDFUrl])
            }
        }
        .navigationDestination(isPresented: $viewModel.nextToEmail) {
            EmailView()
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
