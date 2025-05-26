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

struct ContentView: View {
    @State private var entries: [StockEntry] = []
    @State private var sellingPrice: String = ""
    @State private var showSettings: Bool = false
    @AppStorage("selectedCurrency") private var selectedCurrencyRaw: String = Currency.usd.rawValue
    @State private var selectedCurrencyState: Currency = .usd
    @FocusState private var focusedField: UUID?
    
    private var selectedCurrency: Currency {
        Currency(rawValue: selectedCurrencyRaw) ?? .usd
    }
    
    private var sellingPriceValue: Double {
        Double(sellingPrice) ?? 0
    }
    private func profit(for entry: StockEntry) -> Double {
        let buy = Double(entry.buyPrice) ?? 0
        let shares = Double(entry.shares) ?? 0
        return (sellingPriceValue - buy) * shares
    }
    private var totalProfit: Double {
        entries.reduce(0) { $0 + profit(for: $1) }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Add your stock purchases below. Enter a selling price to see your total potential profit.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach($entries) { $entry in
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Buy Price")
                                    Spacer()
                                    HStack(spacing: 4) {
                                        Text(selectedCurrency.symbol)
                                            .foregroundColor(.secondary)
                                        TextField("0.00", text: $entry.buyPrice)
                                            .keyboardType(.decimalPad)
                                            .multilineTextAlignment(.trailing)
                                            .frame(width: 90)
                                            .textFieldStyle(.roundedBorder)
                                            .focused($focusedField, equals: entry.id)
                                    }
                                }
                                HStack {
                                    Text("Shares")
                                    Spacer()
                                    TextField("0", text: $entry.shares)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                        .frame(width: 100)
                                        .textFieldStyle(.roundedBorder)
                                        .focused($focusedField, equals: entry.id)
                                }
                                HStack {
                                    Spacer()
                                    Button(role: .destructive) {
                                        withAnimation {
                                            entries.removeAll { $0.id == entry.id }
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
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
                    .padding(.vertical, 4)
                }
                
                VStack(spacing: 16) {
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
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                VStack(spacing: 8) {
                    Text("Total Profit")
                        .font(.headline)
                    Text("\(selectedCurrency.symbol)\(totalProfit, specifier: "%.2f")")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(totalProfit >= 0 ? .green : .red)
                        .animation(.easeInOut, value: totalProfit)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                selectedCurrencyState = selectedCurrency
            }
            
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Currency", selection: $selectedCurrencyState) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.symbol).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 50)
                    .labelsHidden()
                    .onChange(of: selectedCurrencyState) { newValue in
                        selectedCurrencyRaw = newValue.rawValue
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .navigationTitle("Stock Profit Calculator")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum Currency: String, CaseIterable, Identifiable {
    case usd, eur, gbp
    var id: String { rawValue }
    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gbp: return "£"
        }
    }
    var name: String {
        switch self {
        case .usd: return "US Dollar ($)"
        case .eur: return "Euro (€)"
        case .gbp: return "British Pound (£)"
        }
    }
}
