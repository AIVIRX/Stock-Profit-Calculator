//
//  ContentView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/24/25.
//

import SwiftUI
import FirebaseAnalytics
import StoreKit

struct CalculatorView: View {
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var interstitialAdManager: InterstitialAdManager
    @Environment(\.requestReview) private var requestReview
    @State private var sessionStart = Date()
    @State private var hasPromptedForReview = false
    @State private var hasShownInterstitialThisSession = false
    @State private var shares: String = ""
    @State private var buyPrice: String = ""
    @State private var sellingPrice: String = ""
    @AppStorage("selectedCurrency") private var selectedCurrencyRaw: String = Currency.usd.rawValue
    @State private var selectedCurrencyState: Currency = .usd
    @State private var commissionFee: String = ""
    
    private var selectedCurrency: Currency {
        Currency(rawValue: selectedCurrencyRaw) ?? .usd
    }
    private var sellingPriceValue: Double {
        parseDouble(sellingPrice)
    }
    private var commissionFeeValue: Double {
        parseDouble(commissionFee)
    }
    private var totalShares: Double {
        parseDouble(shares)
    }
    private var totalCost: Double {
        parseDouble(buyPrice) * totalShares + commissionFeeValue
    }
    private var totalProceeds: Double {
        sellingPriceValue * totalShares
    }
    private var totalProfit: Double {
        totalProceeds - totalCost
    }
    private var breakEvenPrice: Double {
        guard totalShares > 0 else { return 0 }
        return (totalCost) / totalShares
    }

    private func formattedCurrency(_ value: Double) -> String {
        "\(selectedCurrency.symbol)\(String(format: "%.2f", value))"
    }

    private func parseDouble(_ input: String) -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        return formatter.number(from: input)?.doubleValue ?? 0
    }

    private var summaryAnimation: Animation {
        .easeInOut(duration: 0.25)
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(spacing: 6) {
                        Text("Total Profit")
                            .font(.headline)
                        Text(formattedCurrency(totalProfit))
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundStyle(totalProfit >= 0 ? .green : .red)
                            .lineLimit(2)
                            .minimumScaleFactor(0.82)
                            .fixedSize(horizontal: false, vertical: true)
                            .contentTransition(.numericText())
                            .animation(summaryAnimation, value: totalProfit)
                        HStack(spacing: 4) {
                            Text("Break-even")
                                .foregroundStyle(.secondary)
                            Text(formattedCurrency(breakEvenPrice))
                                .fontWeight(.semibold)
                        }
                        .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            TextField("Shares", text: $shares)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 16)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.secondary.opacity(0.35), lineWidth: 1.5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                        HStack(spacing: 12) {
                            Text(selectedCurrency.symbol)
                                .foregroundStyle(.secondary)
                            TextField("Buy Price", text: $buyPrice)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 16)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.secondary.opacity(0.35), lineWidth: 1.5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                        HStack(spacing: 12) {
                            Text(selectedCurrency.symbol)
                                .foregroundStyle(.secondary)
                            TextField("Sell Price", text: $sellingPrice)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 16)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.secondary.opacity(0.35), lineWidth: 1.5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                        HStack(spacing: 12) {
                            Text(selectedCurrency.symbol)
                                .foregroundStyle(.secondary)
                            TextField("Exit Fee", text: $commissionFee)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 16)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.secondary.opacity(0.35), lineWidth: 1.5)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 30, weight: .black, design: .rounded))

                }
                .padding(.horizontal, 6)
                .padding(.top, 6)
                .padding(.bottom, 12)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                endTextEditing()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                selectedCurrencyState = selectedCurrency
            }
            .onChange(of: selectedCurrencyState) { _, newValue in
                selectedCurrencyRaw = newValue.rawValue
            }
            .onChange(of: selectedCurrencyRaw) { _, newValue in
                if let currency = Currency(rawValue: newValue) {
                    selectedCurrencyState = currency
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Currency", selection: $selectedCurrencyState) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.symbol).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    .font(.title)
                    .labelsHidden()
                    .onChange(of: selectedCurrencyState) { _, newValue in
                        selectedCurrencyRaw = newValue.rawValue
                    }
                }
            }
            .navigationTitle("Stock Profit Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                sessionStart = Date()
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if !hasPromptedForReview && Date().timeIntervalSince(sessionStart) > 30 {
                    maybeRequestReview()
                }
                
                // Show interstitial ad after one minute
                if !hasShownInterstitialThisSession && Date().timeIntervalSince(sessionStart) > 15 {
                    if !store.completedPurchases.contains("MAIFER") && interstitialAdManager.isAdReady {
                        let rootVC = UIApplication.shared.topMostViewController()
                        interstitialAdManager.showInterstitial(from: rootVC, placement: AdPlacement.calculatorInterstitial)
                        hasShownInterstitialThisSession = true
                    }
                }
            }
        }
    }

    func maybeRequestReview() {
        let lastPromptDate = UserDefaults.standard.object(forKey: "LastReviewPromptDate") as? Date
        let now = Date()
        let minInterval: TimeInterval = 60 * 60 * 24 * 30 // 30 days

        if lastPromptDate == nil || now.timeIntervalSince(lastPromptDate!) > minInterval {
            requestReview()
            UserDefaults.standard.set(now, forKey: "LastReviewPromptDate")
            hasPromptedForReview = true
        }
    }
}

enum Currency: String, CaseIterable, Identifiable {
    case usd, eur, jpy, gbp, rub, inr, krw
    var id: String { rawValue }
    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .jpy: return "¥"
        case .gbp: return "£"
        case .rub: return "₽"
        case .inr: return "₹"
        case .krw: return "₩"
        }
    }
    
    var name: String {
        switch self {
        case .usd: return "US Dollar ($)"
        case .eur: return "Euro (€)"
        case .jpy: return "Japanese Yen (¥)"
        case .gbp: return "British Pound (£)"
        case .rub: return "Russian Ruble (₽)"
        case .inr: return "Indian Rupee (₹)"
        case .krw: return "South Korean Won (₩)"
        }
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
