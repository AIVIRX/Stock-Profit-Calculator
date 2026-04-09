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
    @Published var adsEnabled: Bool = true
    private let adUnitID = AdUnitID.finalInterstitial

    func loadInterstitial() {
        guard adsEnabled else { return }
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
        guard adsEnabled else {
            completion?()
            return
        }
        guard let interstitial = interstitial else {
            print("Interstitial ad wasn't ready")
            completion?()
            return
        }
        interstitial.present(from: rootViewController)
        self.isAdReady = false
        completion?()
    }

    // Delegate method to reset ad availability after it’s shown
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        guard adsEnabled else { return }
        self.loadInterstitial()
        self.isAdReady = false
    }

    func setAdsEnabled(_ enabled: Bool) {
        adsEnabled = enabled
        if !enabled {
            interstitial = nil
            isAdReady = false
        } else if interstitial == nil {
            loadInterstitial()
        }
    }
}
