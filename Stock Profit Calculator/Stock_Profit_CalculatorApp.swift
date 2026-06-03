//
//  Stock_Profit_CalculatorApp.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/24/25.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds
import AdSupport
import FirebaseCore
import RevenueCat

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebase()
        configureRevenueCat()
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

    private func configureRevenueCat() {
        Purchases.logLevel = .info
        Purchases.configure(withAPIKey: RevenueCatConfig.publicSDKKey)
    }
}

final class Store: NSObject, ObservableObject, PurchasesDelegate {
    @Published var completedPurchases: [String] = []
    @Published var hasDeterminedEntitlement = false
    @Published var hasShownLaunchPaywallThisSession = false

    private let removeAdsProductID = "MAIFER"
    private let removeAdsEntitlementID = "Premium"
    private var hasStarted = false

    override init() {
        super.init()
    }

    func start() {
        guard !hasStarted else { return }
        hasStarted = true
        Purchases.shared.delegate = self

        Task {
            await syncLegacyPurchases()
            await refreshCustomerInfo()
            await MainActor.run {
                self.hasDeterminedEntitlement = true
            }
        }
    }

    func restorePurchases() async {
        do {
            let customerInfo = try await Purchases.shared.restorePurchases()
            await MainActor.run {
                self.apply(customerInfo: customerInfo)
            }
        } catch {
            print("Restore failed: \(error)")
        }
    }

    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        Task {
            await MainActor.run {
                self.apply(customerInfo: customerInfo)
            }
        }
    }

    private func refreshCustomerInfo() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            await MainActor.run {
                self.apply(customerInfo: customerInfo)
            }
        } catch {
            print("Customer info failed: \(error)")
        }
    }

    private func syncLegacyPurchases() async {
        do {
            let customerInfo = try await Purchases.shared.syncPurchases()
            await MainActor.run {
                self.apply(customerInfo: customerInfo)
            }
        } catch {
            print("syncPurchases failed: \(error)")
        }
    }

    private func apply(customerInfo: CustomerInfo) {
        let hasPremium = customerInfo.entitlements.all[removeAdsEntitlementID]?.isActive == true
        completedPurchases = hasPremium ? [removeAdsProductID] : []
    }
}

@main
struct Stock_Profit_CalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var store = Store()
    @StateObject private var interstitialAdManager = InterstitialAdManager()
    
    private var hasNoAds: Bool {
        store.completedPurchases.contains("MAIFER")
    }

    private var canShowAds: Bool {
        store.hasDeterminedEntitlement && !hasNoAds
    }
    
    var body: some Scene {
        WindowGroup {
            VStack{
                if canShowAds {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        AdView(adUnitID: AdUnitID.finalAds)
                            .frame(width: 320, height: 50)
                            .padding(5)
                    }
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        AdView(adUnitID: AdUnitID.finalAds)
                            .frame(width: 468, height: 60)
                            .padding(5)
                    }
                }
                
                ContentView()
                    .environmentObject(store)
                    .environmentObject(interstitialAdManager)
            }
            .onAppear {
                store.start()
                interstitialAdManager.setAdsEnabled(canShowAds)
            }
            .onChange(of: store.completedPurchases) { _, _ in
                interstitialAdManager.setAdsEnabled(canShowAds)
            }
            .onChange(of: store.hasDeterminedEntitlement) { _, _ in
                interstitialAdManager.setAdsEnabled(canShowAds)
            }
        }
    }
}

private enum RevenueCatConfig {
    // Use your RevenueCat iOS Public SDK key.
    static let publicSDKKey = "appl_YHLLRoIHCnOMZXqTqEkcwRfFHbB"
}
