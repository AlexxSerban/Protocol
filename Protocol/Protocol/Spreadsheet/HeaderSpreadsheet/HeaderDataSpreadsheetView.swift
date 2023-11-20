//
//  HeaderDataSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 07.10.2023.
//

import SwiftUI
import UIKit

struct HeaderDataSpreadsheetView: View {
    
    @State var viewModel: HeaderSpreadsheetViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                InputFieldView(label: "Constructor", value: $viewModel.protocolData.constructor)
                InputFieldView(label: "Weekshot", value: $viewModel.protocolData.weekshot)
                    .keyboardType(.numbersAndPunctuation)
                InputFieldView(label: "Area", value: $viewModel.protocolData.area)
                InputFieldView(label: "Street", value: $viewModel.protocolData.street)
                InputFieldView(label: "Pipe Bundle", value: $viewModel.protocolData.pipeBundle)
                    .keyboardType(.numbersAndPunctuation)
                InputFieldView(label: "Total Pipes", value: $viewModel.protocolData.totalPipes)
                    .keyboardType(.numbersAndPunctuation)
                InputFieldView(label: "Drill Length", value: $viewModel.protocolData.drillLength)
                    .keyboardType(.numbersAndPunctuation)
                InputFieldView(label: "Pilot Operator", value: $viewModel.protocolData.pilotOperator)
                InputFieldView(label: "Drilling Rig Operator", value: $viewModel.protocolData.drillingRigOperator)
                InputFieldView(label: "Supervisor", value: $viewModel.protocolData.supervisor)
                
                VStack {
                    Text("Please select the photo signature")
                        .font(.headline)
                    Button(action: {
                        viewModel.isImagePickerPresented.toggle()
                    }) {
                        Text("Select the signature")
                            .padding()
                            .background(Color("ColorBox"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    if let selectedImage = viewModel.protocolData.contractorSignature {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    }
                }
                
                HStack(spacing: 16) {
                    Spacer()
                    Button(action: {
                        viewModel.checkFirmValues()
                    }) {
                        Text("Next")
                            .padding()
                            .background(Color("ColorBox"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $viewModel.isAlertPresentedForData) {
                        Alert(
                            title: Text("Incomplete Data"),
                            message: Text("Please fill in all fields and select a signature photo."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding()
            }
            .padding()
            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                ImagePicker(image: self.$viewModel.protocolData.contractorSignature)
            }
        }
        .padding()
    }
}

struct FirmDataSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDataSpreadsheetView(viewModel: HeaderSpreadsheetViewModel())
    }
}

// InputFieldView for text input with a label
struct InputFieldView: View {
    var label: String
    @Binding var value: String
    
    var body: some View {
        VStack {
            Text("Enter the \(label)")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            TextField("", text: $value)
                .frame(width: 350)
                .keyboardType(.alphabet)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var image: UIImage?
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = uiImage
            }
            
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
}
