//
//  FirmDataSpreadsheetView.swift
//  Protocol
//
//  Created by Alex Serban on 07.10.2023.
//

import SwiftUI
import UIKit

struct FirmDataSpreadsheetView: View {
    // Binding properties for data input
    @Binding var constructor: String
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
    @Binding var showSpreadsheet: Bool
    
    @State var isImagePickerPresented = false
    @State var isDataComplete = false
    @State var isAlertPresented = false
    
    // Body of the view
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                InputFieldView(label: "Constructor", value: $constructor)
                InputFieldView(label: "Weekshot", value: $weekshot)
                InputFieldView(label: "Area", value: $area)
                InputFieldView(label: "Street", value: $street)
                InputFieldView(label: "Drill Length", value: $drillLength)
                InputFieldView(label: "Pilot Operator", value: $pilotOperator)
                InputFieldView(label: "Drilling Rig Operator", value: $drillingRigOperator)
                InputFieldView(label: "Supervisor", value: $supervisor)
                
                VStack {
                    Text("Please select the photo signature")
                        .font(.headline)
                    Button(action: {
                        isImagePickerPresented.toggle()
                    }) {
                        Text("Select the signature")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    if let selectedImage = contractorSignature {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    }
                }
                HStack(spacing: 16) {
                    Spacer()
                    Button(action: {
                        if !constructor.isEmpty && !weekshot.isEmpty && !drillLength.isEmpty &&
                            !pilotOperator.isEmpty && !drillingRigOperator.isEmpty &&
                            !supervisor.isEmpty && contractorSignature != nil {
                            showSpreadsheet = true
                        } else {
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
            .padding()
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: self.$contractorSignature)
            }
        }
        .padding()
    }
}

struct FirmDataSpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        FirmDataSpreadsheetView(
            constructor: .constant(""),
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
            contractorSignature: .constant(nil),
            showSpreadsheet: .constant(false)
        )
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

// ImagePicker to select an image from the photo library
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    // The Coordinator is an inner class that acts as a delegate for UIImagePickerController.
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var image: UIImage?

        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _image = image
        }

        // This method is called when the user selects an image.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = uiImage
            }

            // Close the ImagePicker.
            presentationMode.dismiss()
        }

        // This method is called when the user cancels image selection.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Close the ImagePicker.
            presentationMode.dismiss()
        }
    }

    // This method creates and returns a Coordinator instance.
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    // This method creates and returns a UIImagePickerController instance.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    // This method is used to update the UIImagePickerController instance with the given context.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Nothing needs to be done here, but this method must be implemented.
    }
}
