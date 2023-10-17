//
//  FirmDetailsSpreadsheet.swift
//  Protocol
//
//  Created by Alex Serban on 05.10.2023.
//

import SwiftUI

struct FirmDetailsSpreadsheetView: View {
    // Binding properties to interact with the data
    @Binding var cellValues: [[CellModel]]
    @Binding var firstColumn: [String]
    @Binding var constructor: String
    @Binding var currentDate: Date
    @Binding var weekshot: String
    @Binding var area: String
    @Binding var street: String
    @Binding var pipeBundle: String
    @Binding var drillLength: String
    @Binding var pilotOperator: String
    @Binding var drillingRigOperator: String
    @Binding var supervisor: String
    @Binding var entryPitCoordinates: String
    @Binding var exitPitCoordinates: String
    @Binding var contractorSignature: UIImage?
    
    @State var isDataComplete = false
    @State var isAlertPresented = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                List {
                    // Header of the spreadsheet
                    HStack(spacing: 0) {
                        Image("IconTechnoskopic")
                        Spacer()
                        Text("HDD PROTOCOL")
                            .bold()
                            .font(.title)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .border(Color.black, width: 1)
                    
                    // Section for general info
                    Text("GENERAL INFO")
                        .bold()
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.mint)
                        .border(Color.black, width: 1)
                    
                    // Body cells
                    ForEach(0..<15, id: \.self) { row in
                        HStack(spacing: 0) {
                            Divider()
                            
                            TextField("", text: $cellValues[row][0].text)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Divider()
                                .overlay(Color.black)
                            
                            TextField("", text: $cellValues[row][1].text)
                                .multilineTextAlignment(.center)
                                                .lineLimit(nil)
                        }
                        .border(Color.black, width: 1)
                    }
                    
                    // Row for contractor's signature
                    HStack(spacing: 0) {
                        Divider()
                        
                        TextField("", text: $cellValues[15][0].text)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Divider()
                            .overlay(Color.black)
                        
                        Spacer()
                        
                        if let signatureImage = cellValues[15][1].image {
                            Image(uiImage: signatureImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                        } else {
                            TextField("", text: $cellValues[15][1].text)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }.border(Color.black, width: 1)
                    
                    HStack(spacing: 16) {
                        Spacer()
                        Button(action: {
                            // Check if all required fields are filled
                            if !cellValues[1][0].text.isEmpty &&
                                !cellValues[2][0].text.isEmpty &&
                                !cellValues[3][0].text.isEmpty &&
                                !cellValues[4][0].text.isEmpty &&
                                !cellValues[5][0].text.isEmpty &&
                                !cellValues[6][0].text.isEmpty &&
                                !cellValues[7][0].text.isEmpty &&
                                !cellValues[8][0].text.isEmpty &&
                                !cellValues[9][0].text.isEmpty &&
                                !cellValues[10][0].text.isEmpty &&
                                !cellValues[11][0].text.isEmpty &&
                                !cellValues[12][0].text.isEmpty &&
                                !cellValues[13][0].text.isEmpty &&
                                !cellValues[14][0].text.isEmpty &&
                                !cellValues[15][0].text.isEmpty &&
                                contractorSignature != nil {
                                
                                // Toggle a boolean to proceed to the next step
                                isDataComplete.toggle()
                                
                            } else {
                                // Present an alert if the data is incomplete
                                isAlertPresented.toggle()
                            }
                        }) {
                            Text("Next")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .alert(isPresented: $isAlertPresented) {
                            Alert(
                                title: Text("Incomplete Data"),
                                message: Text("Please fill in all fields and select a signature photo."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .padding()
                }
                .font(.body)
                .padding()
            }
        }
        .navigationDestination(isPresented: $isDataComplete, destination: {
            // Navigate to a view that converts the views into a PDF
            
        })
        .onAppear {
            // Initialize the spreadsheet with data
            for row in 0..<16 {
                cellValues[row][0].text = firstColumn[row]
                cellValues[row][1].text = ""
            }

            cellValues[0][1].text = constructor
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"
            let dateString = dateFormatter.string(from: currentDate)
            cellValues[1][1].text = dateString

            cellValues[2][1].text = weekshot
            cellValues[3][1].text = area
            cellValues[4][1].text = street
            cellValues[5][1].text = pipeBundle
            cellValues[9][1].text = drillLength
            cellValues[10][1].text = pilotOperator
            cellValues[11][1].text = drillingRigOperator
            cellValues[12][1].text = supervisor
            cellValues[13][1].text = entryPitCoordinates
            cellValues[14][1].text = exitPitCoordinates
            cellValues[15][1].image = contractorSignature
        }

    }
}


struct FirmDetailsSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        FirmDetailsSpreadsheetView(
            cellValues: .constant([[CellModel]]()),
            firstColumn: .constant([String]()),
            constructor: .constant(""),
            currentDate: .constant(Date()),
            weekshot: .constant(""),
            area: .constant(""),
            street: .constant(""),
            pipeBundle: .constant(""),
            drillLength: .constant(""),
            pilotOperator: .constant(""),
            drillingRigOperator: .constant(""),
            supervisor: .constant(""),
            entryPitCoordinates: .constant(""),
            exitPitCoordinates: .constant(""),
            contractorSignature: .constant(nil)
        )
    }
}






