//
//  SettingsView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/25/25.
//

import SwiftUI
import StoreKit
import RevenueCatUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject private var store: Store
    @State private var isShowingPaywall = false
    @State private var isRestoringPurchases = false

    private var hasNoAds: Bool {
        store.completedPurchases.contains("MAIFER")
    }

    private var cryptoAppURL: URL? { URL(string: "https://apps.apple.com/us/app/crypto-profit-loss-calculator/id1638849680") }
    private var miniHabitsURL: URL? { URL(string: "https://apps.apple.com/us/app/minihabits-habit-tracker/id6749192623") }
    private var privacyPolicyURL: URL? { URL(string: "https://www.aivirx.com/stock-profit-calculator/privacy-policy") }
    private var termsURL: URL? { URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") }
    private var supportEmailURL: URL? { URL(string: "mailto:support@aivirx.com?subject=Stocks%20Profit%20Calculator") }

    var body: some View {
        NavigationStack {
            VStack{
                Button {
                    isShowingPaywall = true
                } label: {
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: hasNoAds ? "checkmark.seal.fill" : "xmark.seal.fill")
                                    .foregroundColor(hasNoAds ? .green : .red)
                                Text("Shop")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            Text(hasNoAds ? "Premium unlocked" : "Unlock Premium Features")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.indigo.gradient))
                .padding(.horizontal)
                .padding(.top)
                
                Form {
                    Section(header: Text("Support Us")) {
                        Button {
                            requestReview()
                        } label: {
                            HStack {
                                Image(systemName: "star.leadinghalf.filled")
                                    .font(.system(size: 20))
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.white)
                                    .background(Color.orange)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Text("Rate Us")
                            }
                        }
                        Button {
                            Task {
                                await MainActor.run {
                                    isRestoringPurchases = true
                                }
                                await store.restorePurchases()
                                await MainActor.run {
                                    isRestoringPurchases = false
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                    .font(.system(size: 20))
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.white)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Text(isRestoringPurchases ? "Restoring..." : "Restore Purchases")
                            }
                        }
                        .disabled(isRestoringPurchases)
                    }
                    
                    Section(header: Text("Our Apps")) {
                        if let cryptoAppURL {
                            Link(destination: cryptoAppURL) {
                                HStack {
                                    Image("CryptoProfitCalc")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(5)
                                    Text("Crypto Profit Loss Calculator")
                                }
                            }
                        }
                        
                        if let miniHabitsURL {
                            Link(destination: miniHabitsURL) {
                                HStack {
                                    Image("minihabits")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(5)
                                    Text("MiniHabits - Habit Tracker")
                                }
                            }
                        }
                    }
                    
                    Section("Privacy & Support") {
                        if let privacyPolicyURL {
                            Link(destination: privacyPolicyURL) {
                                Text("Privacy Policy")
                            }
                        }
                        if let termsURL {
                            Link(destination: termsURL) {
                                Text("Terms of Service")
                            }
                        }
                        if let supportEmailURL {
                            Link(destination: supportEmailURL) {
                                Text("Contact Us")
                            }
                        }
                    }
                }
                .accentColor(colorScheme == .dark ? .white : .black)
                .navigationBarTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isShowingPaywall) {
                    PaywallView()
                }
            }
        }
    }
}
