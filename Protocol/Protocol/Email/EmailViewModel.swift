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
    
    var protocolData = ProtocolData.sharedData
    var isShowingMailView = false
    var result: Result<MFMailComposeResult, Error>?
    var selectedImagesForEmail: [UIImage] = []
    var toEmails = ["alexserbandaniel@yahoo.com"]
    var fromEmail = "alexserbandaniel@yahoo.com"
    var emailSubject = ""
    var emailBody = ""
    var protocolPDF: PDFDocument?
    let formattedDate = DateFormatter().string(from: Date()) 

    func attachImages() {
        if let firstEntryImage = protocolData.firstEntryImage {
            selectedImagesForEmail.append(firstEntryImage)
        }
        if let secondEntryImage = protocolData.secondEntryImage {
            selectedImagesForEmail.append(secondEntryImage)
        }
        if let firstExitImage = protocolData.firstExitImage {
            selectedImagesForEmail.append(firstExitImage)
        }
        if let secondExitImage = protocolData.secondExitImage {
            selectedImagesForEmail.append(secondExitImage)
        }
    }

    func selectPDF() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }

    func composeEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(toEmails)
            mailComposeViewController.setSubject(emailSubject)
            mailComposeViewController.setMessageBody(emailBody, isHTML: false)

            for image in selectedImagesForEmail {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    mailComposeViewController.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "image.jpg")
                }
            }

            if let pdfURL = protocolData.pdfFileURL {
                if let pdfData = try? Data(contentsOf: pdfURL) {
                    mailComposeViewController.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: pdfURL.lastPathComponent)
                }
            }

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
    }
    
    func getPDF() {
        if let pdfURL = protocolData.pdfFileURL {
            do {
                let pdfData = try Data(contentsOf: pdfURL)

                let pdfDocument = PDFDocument(data: pdfData)

                protocolPDF = pdfDocument
            } catch {}
        }
    }
}

