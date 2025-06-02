//
//  ContentView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/24/25.
//

import SwiftUI

struct StockEntry: Identifiable {
    let id = UUID()
    var buyPrice: String
    var shares: String
}

struct CalculatorView: View {
    @EnvironmentObject private var store: Store
    @State private var entries: [StockEntry] = []
    @State private var sellingPrice: String = ""
    @AppStorage("selectedCurrency") private var selectedCurrencyRaw: String = Currency.usd.rawValue
    @State private var selectedCurrencyState: Currency = .usd
    @FocusState private var focusedField: UUID?
    @State private var commissionFee: String = ""
    @State private var deletingIDs: Set<UUID> = []
    
    private var selectedCurrency: Currency {
        Currency(rawValue: selectedCurrencyRaw) ?? .usd
    }
    private var sellingPriceValue: Double {
        Double(sellingPrice) ?? 0
    }
    private var commissionFeeValue: Double {
        Double(commissionFee) ?? 0
    }
    private var totalShares: Double {
        entries.reduce(0) { $0 + (Double($1.shares) ?? 0) }
    }
    private var totalCost: Double {
        entries.reduce(0) { $0 + ((Double($1.buyPrice) ?? 0) * (Double($1.shares) ?? 0)) } + commissionFeeValue
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
    private func deleteEntry(withId id: UUID) {
        // Prevent double delete
        guard !deletingIDs.contains(id) else { return }
        deletingIDs.insert(id)
        if entries.firstIndex(where: { $0.id == id }) != nil {
            if entries.count == 1 || focusedField == id {
                focusedField = nil
            }
            // Remove after animation completes
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                if let index = entries.firstIndex(where: { $0.id == id }) {
                    entries.remove(at: index)
                }
                deletingIDs.remove(id)
            }
        } else {
            print("[Delete Error] Tried to delete entry with id \(id), but it was not found in entries.")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Add your stock purchases below. Enter a selling price and commission fee to see your total potential profit.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    VStack(spacing: 12) {
                        if !entries.isEmpty {
                            ForEach(Array(entries.enumerated()), id: \.element.id) { (index, entry) in
                                VStack(spacing: 12) {
                                    HStack {
                                        Text("Shares")
                                        Spacer()
                                        TextField("0", text: $entries[index].shares)
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(.trailing)
                                            .frame(width: 100)
                                            .textFieldStyle(.roundedBorder)
                                            .focused($focusedField, equals: entry.id)
                                    }
                                    HStack {
                                        Text("Buy Price")
                                        Spacer()
                                        HStack(spacing: 4) {
                                            Text(selectedCurrency.symbol)
                                                .foregroundColor(.secondary)
                                            TextField("0.00", text: $entries[index].buyPrice)
                                                .keyboardType(.decimalPad)
                                                .multilineTextAlignment(.trailing)
                                                .frame(width: 90)
                                                .textFieldStyle(.roundedBorder)
                                        }
                                    }
                                    HStack {
                                        Spacer()
                                        Button(role: .destructive) {
                                            withAnimation {
                                                deleteEntry(withId: entry.id)
                                            }
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                        .disabled(deletingIDs.contains(entry.id))
                                    }
                                }
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .transition(.move(edge: .trailing))
                            }
                        }
                        Button {
                            withAnimation {
                                let newEntry = StockEntry(buyPrice: "", shares: "")
                                entries.append(newEntry)
                                focusedField = newEntry.id
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 28))
                                Text("Add Entry")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [6]))
                                    .foregroundColor(.accentColor.opacity(0.3))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                VStack(spacing: 6) {
                    HStack {
                        Text("Selling Price")
                        Spacer()
                        HStack(spacing: 4) {
                            Text(selectedCurrency.symbol)
                                .foregroundColor(.secondary)
                            TextField("0.00", text: $sellingPrice)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 110)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                VStack(spacing: 6) {
                    HStack {
                        Text("Commission Fee")
                        Spacer()
                        HStack(spacing: 4) {
                            Text(selectedCurrency.symbol)
                                .foregroundColor(.secondary)
                            TextField("0.00", text: $commissionFee)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 90)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                VStack(spacing: 6) {
                    Text("Total Profit")
                        .font(.headline)
                    Text("\(selectedCurrency.symbol)\(totalProfit, specifier: "%.2f")")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(totalProfit >= 0 ? .green : .red)
                        .animation(.easeInOut, value: totalProfit)
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                Spacer()
            }
            .padding(6)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                selectedCurrencyState = selectedCurrency
            }
            .onChange(of: selectedCurrencyState) { newValue in
                selectedCurrencyRaw = newValue.rawValue
            }
            .onChange(of: selectedCurrencyRaw) { newValue in
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
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 60))
                    .labelsHidden()
                    .onChange(of: selectedCurrencyState) { newValue in
                        selectedCurrencyRaw = newValue.rawValue
                    }
                }
            }
            .navigationTitle("Stock Profit Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                store.loadStoredPurchases()
            }
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
