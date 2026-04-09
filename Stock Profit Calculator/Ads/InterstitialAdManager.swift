//
//  InterstitialAdManager.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 7/30/25.
//


import GoogleMobileAds
import SwiftUI

class InterstitialAdManager: NSObject, ObservableObject, FullScreenContentDelegate {
    private var interstitial: InterstitialAd?
    @Published var isAdReady: Bool = false
    private let adUnitID = AdUnitID.finalinterstitial
    
    // Timer for tracking app usage
    private var appUsageTimer: Timer?
    private var appUsageStartTime: Date?
    private let appUsageThreshold: TimeInterval = 60 // 1 minute in seconds

    func loadInterstitial() {
        InterstitialAd.load(with: adUnitID, request: Request()) { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                self?.isAdReady = false
                return
            }
            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
            self?.isAdReady = true
        }
    }

    func showInterstitial(from rootViewController: UIViewController, completion: (() -> Void)? = nil) {
        guard let interstitial = interstitial else {
            print("Interstitial ad wasn't ready")
            completion?()
            return
        }
        interstitial.present(from: rootViewController)
        self.isAdReady = false
        completion?()
    }
    
    // Start tracking app usage time
    func startAppUsageTracking() {
        appUsageStartTime = Date()
        appUsageTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkAppUsageTime()
        }
    }
    
    // Stop tracking app usage time
    func stopAppUsageTracking() {
        appUsageTimer?.invalidate()
        appUsageTimer = nil
        appUsageStartTime = nil
    }
    
    // Check if app has been used for the threshold time
    private func checkAppUsageTime() {
        guard let startTime = appUsageStartTime else { return }
        
        let elapsedTime = Date().timeIntervalSince(startTime)
        if elapsedTime >= appUsageThreshold {
            // Show interstitial ad after 1 minute of app usage
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    self.showInterstitial(from: rootViewController)
                }
            }
            // Reset timer after showing ad
            stopAppUsageTracking()
            startAppUsageTracking()
        }
    }

    // Delegate method to reset ad availability after it's shown
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        self.loadInterstitial()
        self.isAdReady = false
    }
} 