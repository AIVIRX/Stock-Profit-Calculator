# Stock Profit Calculator

A native iOS app for quickly estimating the outcome of a stock trade. Enter the number of shares, purchase price, sell price, and exit fee to see the projected profit or loss and break-even price.

## Highlights

- Calculates projected profit/loss and break-even price in real time
- Supports USD, EUR, JPY, GBP, RUB, INR, and KRW
- Includes a lightweight stock-market trivia experience
- Offers an ad-free purchase with RevenueCat purchase restoration
- Uses Firebase Analytics and Google Mobile Ads for product analytics and monetization

## Tech stack

- Swift and SwiftUI
- StoreKit and RevenueCat
- Firebase Analytics
- Google Mobile Ads SDK
- Swift Package Manager

## Getting started

1. Clone the repository.
2. Open [Stock Profit Calculator.xcodeproj](Stock%20Profit%20Calculator.xcodeproj) in Xcode.
3. Choose an iOS simulator or device and run the `Stock Profit Calculator` scheme.

Dependencies resolve through Swift Package Manager. The repository includes the Firebase configuration used by the app; use your own configuration when building a fork or production variant.

## Project structure

```
Stock Profit Calculator/
├── Components/       # Ads and shared constants
├── Resources/        # Assets and localization resources
├── Views/            # Calculator, trivia, and settings screens
└── Stock_Profit_CalculatorApp.swift
```

## Notes

This project is a portfolio example and is not financial advice. Results are estimates and do not account for every possible tax, fee, or market condition.

