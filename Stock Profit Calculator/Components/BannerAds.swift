//
//  BannerAds.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/26/25.
//

import SwiftUI
import GoogleMobileAds
@_spi(Experimental) import RevenueCatAdMob

struct AdView: UIViewRepresentable{
    var adUnitID: String
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<AdView>) -> BannerView{
        let banner = BannerView(adSize: AdSizeBanner)
        
        banner.adUnitID = adUnitID
        banner.rootViewController = UIApplication.shared.topMostViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let request = Request()
            request.scene = windowScene
            banner.loadAndTrack(
                request: request,
                placement: AdPlacement.homeBanner,
                delegate: context.coordinator
            )
        }
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: UIViewRepresentableContext<AdView>) {
    }
    
    class Coordinator: NSObject, BannerViewDelegate{
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("bannerViewDidReceiveAd")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        func bannerViewDidRecordImpression(_ bannerView: BannerView) {
            print("bannerViewDidRecordImpression")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: BannerView) {
            print("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: BannerView) {
            print("bannerViewWillDIsmissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: BannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}

// Conditional banner ad that only shows if user hasn't purchased no-ads IAP
struct ConditionalAdView: View {
    let adUnitID: String
    @EnvironmentObject private var store: Store
    
    var body: some View {
        if !store.completedPurchases.contains("MAIFER") {
            AdView(adUnitID: adUnitID)
                .frame(width: 320, height: 50)
                .padding(3)
        }
    }
}

extension UIApplication{
    func topMostViewController() -> UIViewController {
        guard let screen = connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let root = screen.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return .init()
        }

        var topController = root
        while let presented = topController.presentedViewController {
            topController = presented
        }
        return topController
    }
}
