//
//  SettingsView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/25/25.
//

import SwiftUI
import StoreKit
import MessageUI
import RevenueCatUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentationMode: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentationMode = presentationMode
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                $presentationMode.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["support@aivirx.com"])
        vc.setSubject("Stocks Profit Calculator")
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject private var store: Store
    @State private var errorMessage: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    @State private var isShowingPaywall = false
    @Environment(\.dismiss) var dismiss

    private var hasNoAds: Bool {
        store.completedPurchases.contains("MAIFER")
    }

    var body: some View {
        NavigationStack {
            VStack{
                Button {
                    isShowingPaywall = true
                } label: {
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.orange)
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
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
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
                    }
                    
                    Section(header: Text("Our Apps")) {
                        Link(destination: URL(string: "https://apps.apple.com/us/app/crypto-profit-loss-calculator/id1638849680")!) {
                            HStack {
                                Image("CryptoProfitCalc")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(5)
                                Text("Crypto Profit Loss Calculator")
                            }
                        }
                        
                        Link(destination: URL(string: "https://apps.apple.com/us/app/minihabits-habit-tracker/id6749192623")!) {
                            HStack {
                                Image("minihabits")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(5)
                                
                                Text("MiniHabits - Habit Tracker")
                            }
                        }
                    }
                    
                    Section("Privacy & Support") {
                        Link(destination: URL(string: "https://www.aivirx.com/stock-profit-calculator/privacy-policy")!) {
                            Text("Privacy Policy")
                        }
                        Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                            Text("Terms of Service")
                        }
                        Button(action: {
                            isShowingMailView.toggle()
                        }) {
                            Text("Contact Us")
                        }
                        .disabled(!MFMailComposeViewController.canSendMail())
                    }
                }
                .accentColor(colorScheme == .dark ? .white : .black)
                .navigationBarTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: $result)
                }
                .sheet(isPresented: $isShowingPaywall) {
                    PaywallView()
                }
            }
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}
