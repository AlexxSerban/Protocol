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
        NavigationStack {
            ScrollView {
                VStack{
                    PDFView()
                }

                HStack {
                    Button {
                        exportPDF {
                            PDFView()
                        } completion: { status, url in
                            if let url = url, status {
                                viewModel.PDFUrl = url
                                viewModel.showShareSheet.toggle()
                            }
                            else {
                                print("Failed to produce PDF")
                            }
                        }
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
                .padding()
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
        .navigationDestination(isPresented: $viewModel.nextToEmail) {
            //Add the next View
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
