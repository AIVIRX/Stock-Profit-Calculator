//
//  SettingsView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/25/25.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject private var store: Store
    @Environment(\.colorScheme) var colorScheme
    private let url = URL(string: "https://apps.apple.com/us/app/crypto-profit-loss-calculator/id1638849680")!
    @Environment(\.requestReview) var requestReview
    let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    HStack{
                        Text("Settings")
                            .font(.largeTitle.bold())
                            .padding()
                        Spacer()
                    }
                    NavigationLink(destination: StoreView()){
                        ZStack{
                            Color.indigo
                                .cornerRadius(20)
                            HStack{
                                VStack{
                                    HStack{
                                        Text("Shop")
                                            .foregroundColor(Color.white)
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                    }
                                    HStack{
                                        Text("Remove ads forever!")
                                            .foregroundColor(Color.white)
                                            .font(.callout)
                                        Spacer()
                                    }
                                }.padding()
                                VStack{
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(Color.yellow)
                                        .padding()
                                }
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                    .padding(.bottom, 30)
                    
                    HStack{
                        ShareLink(item: url){
                            Label("Share Crypto Profit Loss Calculator", systemImage: "square.and.arrow.up")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.regularMaterial)
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                                .contentShape(Rectangle())
                        }
                    }
                    
                    Button { requestReview()}
                    
                    label: {
                        HStack{
                            Image(systemName: "bubble.left.and.bubble.right")
                            Text("Rate Our App")
                        }
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.regularMaterial)
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .contentShape(Rectangle())
                    }
                    
                    
                    
                    Link(destination: URL(string: "https://www.aivirx.com/crypto-profit-loss-calculator/privacy-policy")!){
                        Text("Privacy Policy")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.regularMaterial)
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                            .contentShape(Rectangle())
                    }
                    
                    Link(destination: URL(string: "https://www.aivirx.com/contact")!){
                        Text("Contact Us")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.regularMaterial)
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                            .contentShape(Rectangle())
                    }
                }
                .padding(5)
            }
        }
    }
}
