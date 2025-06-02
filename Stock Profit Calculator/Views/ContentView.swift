//
//  ContentView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/27/25.
//

import SwiftUI
import StatefulTabView

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var store: Store
    var body: some View {
        if store.completedPurchases.isEmpty {
            AdView(adUnitID: AdUnitID.finalAd)
                .frame(width: 320, height: 50)
                .padding(3)
        }
        StatefulTabView {
            Tab(title: "Home",systemImageName: "house.fill") {
                CalculatorView()
            }
            
            Tab(title: "Trivia", systemImageName: "trophy.fill") {
                StocksTriviaView()
            }
            
            Tab(title: "Settings", systemImageName: "gearshape.fill") {
                SettingsView()
            }
        }
        .accentColor(colorScheme == .dark ? .white : .black)
    }
}
