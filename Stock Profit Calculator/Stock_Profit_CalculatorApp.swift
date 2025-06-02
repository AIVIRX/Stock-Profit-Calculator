//
//  Stock_Profit_CalculatorApp.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/24/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import AppTrackingTransparency
import FirebaseAnalytics
import AdSupport
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebase()
        requestTrackingAuthorization()
        initializeGoogleMobileAds()
            
        return true
    }
    
    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("TRACKING ENABLED \(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
                    case .denied:
                        print("TRACKING DISABLED \(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
                    default:
                        print("DEFAULT TRACKING \(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
                    }
                }
            }
        } else {
            print("iOS version is below 14.0, no tracking authorization needed.")
        }
    }
    
    private func initializeGoogleMobileAds() {
        MobileAds.shared.start(completionHandler: nil)
    }
    
    private func configureFirebase() {
        FirebaseApp.configure()
    }
}

@main
struct Stock_Profit_CalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)

        }
    }
}
