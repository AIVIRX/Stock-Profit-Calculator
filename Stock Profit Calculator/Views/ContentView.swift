//
//  ContentView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var store: Store
    @State private var selectedTab: Tabs = .home

    enum Tabs: Hashable {
            case home
            case trivia
            case settings
        }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                CalculatorView()
            }
            
            Tab("Trivia", systemImage: "trophy.fill", value: .trivia) {
                StocksTriviaView()
            }
            
            Tab("Settings", systemImage: "gearshape.fill", value: .settings) {
                SettingsView()
            }
        }
        .accentColor(colorScheme == .dark ? .white : .black)
    }
}
