//
//  ImagePickerView.swift
//  Protocol
//
//  Created by Alex Serban on 12.09.2023.
//

import Foundation
import SwiftUI

// Define a struct named ImagePickerView that conforms to UIViewControllerRepresentable.
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // A binding for the selected image.
    @Binding var isPresented: Bool // A binding to control the presentation of the image picker.

    // This function creates and configures a UIImagePickerController instance.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    // This function is empty because there is no need to update the view controller in this context.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    // This function creates and returns an instance of the Coordinator class to handle interactions with the image picker.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Define a nested class Coordinator that conforms to NSObject, UINavigationControllerDelegate, and UIImagePickerControllerDelegate.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        // Initialize the Coordinator with a reference to the parent ImagePickerView.
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        // This function is called when an image is selected using the image picker.
        // It extracts the selected image from the info dictionary and assigns it to the selectedImage property of the parent ImagePickerView.
        // It also sets isPresented to false to dismiss the image picker.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }

        // This function is called when the user cancels image selection.
        // It sets isPresented to false to dismiss the image picker.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}
