//
//  MailComposeView.swift
//  Protocol
//
//  Created by Alex Serban on 30.10.2023.
//

import SwiftUI
import MessageUI

struct MailComposeView: View {
    @State var viewModel = EmailViewModel()

    var body: some View {
        VStack {
            Text("New Email")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
//            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("To:")
//                    Text("\(viewModel.toEmails)")
                        
                }
                HStack {
                    Text("From:")
                    TextField("Sender", text: $viewModel.fromEmail)
                }
                HStack {
                    Text("Subject:")
                    TextField("Subject", text: $viewModel.emailSubject)
                }
                HStack {
                    TextEditor(text: $viewModel.emailBody)
                        .frame(height: 200)
                        .cornerRadius(10)
                }
            }

            HStack {
                Spacer()
                Button(action: {
                    MailComposeView.mailComposeVC.setSubject(viewModel.emailSubject)
                    MailComposeView.mailComposeVC.setMessageBody(viewModel.emailBody, isHTML: false)
                    viewModel.result = nil
                }) {
                    Text("Send")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
//        .background(Color.white)
        .onAppear {
            viewModel.attachImages()
        }
    }

    static var mailComposeVC: MFMailComposeViewController = {
        let mailComposeVC = MFMailComposeViewController()
        return mailComposeVC
    }()
}

#Preview {
    MailComposeView(viewModel: EmailViewModel())
}

