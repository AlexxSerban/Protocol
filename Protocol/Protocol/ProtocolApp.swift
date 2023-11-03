//
//  ProtocolApp.swift
//  Protocol
//
//  Created by Alex Serban on 12.09.2023.
//

import SwiftUI
import UIKit
import AVFoundation
import CoreLocation

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    @StateObject var locationManager = LocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }
}

@main
struct ProtocolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var locationManager = LocationManager()

    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationManager)
//            ProtocolPDFView()
//            MainSpreadsheetView()
//                .environmentObject(locationManager)
//            EmailView()
//            MailComposeView()
        }
    }
}
