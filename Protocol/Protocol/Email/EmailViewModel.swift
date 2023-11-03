//
//  EmailViewModel.swift
//  Protocol
//
//  Created by Alex Serban on 29.10.2023.
//

import SwiftUI
import MessageUI
import MobileCoreServices
import UniformTypeIdentifiers
import Observation
import PDFKit

@Observable
class EmailViewModel: NSObject, MFMailComposeViewControllerDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var isShowingMailView = false
    var result: Result<MFMailComposeResult, Error>?
    var selectedImages: [UIImage] = []
    var protocolData = ProtocolData.sharedData
    var toEmails = ["alexserbandaniel@yahoo.com"]
    var fromEmail = "alexserbandaniel@yahoo.com"
    var emailSubject = "Your email subject here" // Set your email subject
    var emailBody = "Your email body here" // Set your email body
    var protocolPDF: PDFDocument?

    // Function to attach the selected images
    func attachImages() {
        if let firstEntryImage = protocolData.firstEntryImage {
            selectedImages.append(firstEntryImage)
        }
        if let secondEntryImage = protocolData.secondEntryImage {
            selectedImages.append(secondEntryImage)
        }
        if let firstExitImage = protocolData.firstExitImage {
            selectedImages.append(firstExitImage)
        }
        if let secondExitImage = protocolData.secondExitImage {
            selectedImages.append(secondExitImage)
        }
    }

    // Function to present the document picker for PDF selection
    func selectPDF() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }

    // Function to compose and present the email
    func composeEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(toEmails)
            mailComposeViewController.setSubject(emailSubject)
            mailComposeViewController.setMessageBody(emailBody, isHTML: false)

            // Attach images
            for image in selectedImages {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    mailComposeViewController.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "image.jpg")
                }
            }

            // Attach PDF file if available
            if let pdfURL = protocolData.pdfFileURL {
                if let pdfData = try? Data(contentsOf: pdfURL) {
                    mailComposeViewController.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: pdfURL.lastPathComponent)
                }
            }

            // Present the email composer
            UIApplication.shared.windows.first?.rootViewController?.present(mailComposeViewController, animated: true, completion: nil)
        }
    }

    // MARK: - MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            self.result = .success(result)
        }
    }

    // MARK: - UIDocumentPickerDelegate

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let pdfURL = urls.first {
            protocolData.pdfFileURL = pdfURL
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle cancellation if needed
    }
    
    
    func getPDF() {
        if let pdfURL = protocolData.pdfFileURL {
            do {
                // Load the PDF file into a variable
                let pdfData = try Data(contentsOf: pdfURL)

                // Create a new PDFDocument object from the data
                let pdfDocument = PDFDocument(data: pdfData)

                // Assign the PDFDocument object to a variable
                protocolPDF = pdfDocument
            } catch {
                // Handle error
            }
        }
    }
}

