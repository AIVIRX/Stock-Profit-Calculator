//
//  StocksTriviaView.swift
//  Stock Profit Calculator
//
//  Created by Maicol Cabreja on 5/27/25.
//

import SwiftUI

// MARK: - Models
struct TriviaChapter: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let questions: [TriviaQuestion]
}

struct TriviaQuestion: Identifiable, Hashable {
    let id = UUID()
    let question: String
    let answers: [TriviaAnswer]
    let correctIndex: Int
    let explanation: String?
}

struct TriviaAnswer: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

// MARK: - Sample Data
let sampleChapters: [TriviaChapter] = [
    // Stock Basics
    TriviaChapter(
        title: "Stock Basics",
        icon: "chart.bar.xaxis",
        color: .blue,
        questions: [
            TriviaQuestion(
                question: "What is a stock?",
                answers: [
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A share in a company"),
                    TriviaAnswer(text: "A loan to the government"),
                    TriviaAnswer(text: "A type of currency")
                ],
                correctIndex: 1,
                explanation: "A stock represents a share in the ownership of a company."
            ),
            TriviaQuestion(
                question: "What does IPO stand for?",
                answers: [
                    TriviaAnswer(text: "Initial Price Offering"),
                    TriviaAnswer(text: "Initial Public Offering"),
                    TriviaAnswer(text: "International Purchase Order"),
                    TriviaAnswer(text: "Investment Portfolio Option")
                ],
                correctIndex: 1,
                explanation: "IPO stands for Initial Public Offering, which is when a company first sells its shares to the public."
            ),
            TriviaQuestion(
                question: "What is a dividend?",
                answers: [
                    TriviaAnswer(text: "A fee paid to brokers"),
                    TriviaAnswer(text: "A portion of company profits paid to shareholders"),
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A government tax")
                ],
                correctIndex: 1,
                explanation: "A dividend is a portion of a company's profits paid to shareholders."
            ),
            TriviaQuestion(
                question: "Which of the following is NOT a stock exchange?",
                answers: [
                    TriviaAnswer(text: "NYSE"),
                    TriviaAnswer(text: "NASDAQ"),
                    TriviaAnswer(text: "S&P 500"),
                    TriviaAnswer(text: "London Stock Exchange")
                ],
                correctIndex: 2,
                explanation: "The S&P 500 is a stock index, not an exchange."
            ),
            TriviaQuestion(
                question: "What does it mean to 'go public'?",
                answers: [
                    TriviaAnswer(text: "To sell company shares to the public for the first time"),
                    TriviaAnswer(text: "To announce a new product"),
                    TriviaAnswer(text: "To merge with another company"),
                    TriviaAnswer(text: "To pay dividends")
                ],
                correctIndex: 0,
                explanation: "Going public means selling company shares to the public for the first time, usually via an IPO."
            ),
            TriviaQuestion(
                question: "What is a ticker symbol?",
                answers: [
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A unique series of letters representing a stock"),
                    TriviaAnswer(text: "A trading strategy"),
                    TriviaAnswer(text: "A government regulation")
                ],
                correctIndex: 1,
                explanation: "A ticker symbol is a unique series of letters representing a stock on an exchange."
            ),
            TriviaQuestion(
                question: "What is market capitalization?",
                answers: [
                    TriviaAnswer(text: "The total value of a company's outstanding shares"),
                    TriviaAnswer(text: "The number of employees in a company"),
                    TriviaAnswer(text: "The amount of cash a company has"),
                    TriviaAnswer(text: "The number of products a company sells")
                ],
                correctIndex: 0,
                explanation: "Market capitalization is the total value of a company's outstanding shares."
            ),
            TriviaQuestion(
                question: "What is a blue-chip stock?",
                answers: [
                    TriviaAnswer(text: "A stock with a blue logo"),
                    TriviaAnswer(text: "A stock from a well-established, financially sound company"),
                    TriviaAnswer(text: "A penny stock"),
                    TriviaAnswer(text: "A stock that is always rising")
                ],
                correctIndex: 1,
                explanation: "Blue-chip stocks are shares of well-established, financially sound companies."
            ),
            TriviaQuestion(
                question: "What is a bear market?",
                answers: [
                    TriviaAnswer(text: "A market where prices are rising"),
                    TriviaAnswer(text: "A market where prices are falling"),
                    TriviaAnswer(text: "A market with no change"),
                    TriviaAnswer(text: "A market for animal products")
                ],
                correctIndex: 1,
                explanation: "A bear market is characterized by falling prices."
            ),
            TriviaQuestion(
                question: "What is a bull market?",
                answers: [
                    TriviaAnswer(text: "A market where prices are rising"),
                    TriviaAnswer(text: "A market where prices are falling"),
                    TriviaAnswer(text: "A market with no change"),
                    TriviaAnswer(text: "A market for animal products")
                ],
                correctIndex: 0,
                explanation: "A bull market is characterized by rising prices."
            ),
            TriviaQuestion(
                question: "What is an equity?",
                answers: [
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "Ownership in a company"),
                    TriviaAnswer(text: "A government tax"),
                    TriviaAnswer(text: "A trading strategy")
                ],
                correctIndex: 1,
                explanation: "Equity represents ownership in a company."
            ),
            TriviaQuestion(
                question: "What is a portfolio?",
                answers: [
                    TriviaAnswer(text: "A collection of investments"),
                    TriviaAnswer(text: "A type of stock"),
                    TriviaAnswer(text: "A government bond"),
                    TriviaAnswer(text: "A trading platform")
                ],
                correctIndex: 0,
                explanation: "A portfolio is a collection of investments owned by an individual or organization."
            ),
            TriviaQuestion(
                question: "What is diversification?",
                answers: [
                    TriviaAnswer(text: "Investing in a single stock"),
                    TriviaAnswer(text: "Spreading investments across different assets"),
                    TriviaAnswer(text: "Selling all stocks"),
                    TriviaAnswer(text: "Buying only bonds")
                ],
                correctIndex: 1,
                explanation: "Diversification means spreading investments across different assets to reduce risk."
            ),
            TriviaQuestion(
                question: "What is a mutual fund?",
                answers: [
                    TriviaAnswer(text: "A fund managed by multiple people"),
                    TriviaAnswer(text: "A pool of money from many investors to buy a diversified portfolio"),
                    TriviaAnswer(text: "A government bond"),
                    TriviaAnswer(text: "A type of stock exchange")
                ],
                correctIndex: 1,
                explanation: "A mutual fund pools money from many investors to buy a diversified portfolio of stocks, bonds, or other securities."
            ),
            TriviaQuestion(
                question: "What is a penny stock?",
                answers: [
                    TriviaAnswer(text: "A stock that costs less than $5 per share"),
                    TriviaAnswer(text: "A stock that pays no dividends"),
                    TriviaAnswer(text: "A stock from a blue-chip company"),
                    TriviaAnswer(text: "A stock traded on the NYSE")
                ],
                correctIndex: 0,
                explanation: "A penny stock is typically a stock that trades for less than $5 per share."
            ),
            TriviaQuestion(
                question: "What is a limit order?",
                answers: [
                    TriviaAnswer(text: "An order to buy or sell at a specific price or better"),
                    TriviaAnswer(text: "An order to buy at any price"),
                    TriviaAnswer(text: "An order to sell only at market close"),
                    TriviaAnswer(text: "An order to buy only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "A limit order is an order to buy or sell a stock at a specific price or better."
            ),
            TriviaQuestion(
                question: "What is a market order?",
                answers: [
                    TriviaAnswer(text: "An order to buy or sell immediately at the best available price"),
                    TriviaAnswer(text: "An order to buy at a specific price"),
                    TriviaAnswer(text: "An order to sell only at market close"),
                    TriviaAnswer(text: "An order to buy only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "A market order is an order to buy or sell a stock immediately at the best available price."
            ),
            TriviaQuestion(
                question: "What is a stock split?",
                answers: [
                    TriviaAnswer(text: "When a company divides its existing shares into multiple shares"),
                    TriviaAnswer(text: "When a company merges with another"),
                    TriviaAnswer(text: "When a company pays a dividend"),
                    TriviaAnswer(text: "When a company goes bankrupt")
                ],
                correctIndex: 0,
                explanation: "A stock split is when a company divides its existing shares into multiple shares to boost liquidity."
            ),
            TriviaQuestion(
                question: "What is an earnings report?",
                answers: [
                    TriviaAnswer(text: "A report showing a company's financial performance for a period"),
                    TriviaAnswer(text: "A government tax form"),
                    TriviaAnswer(text: "A trading strategy"),
                    TriviaAnswer(text: "A type of bond")
                ],
                correctIndex: 0,
                explanation: "An earnings report shows a company's financial performance for a specific period, usually a quarter."
            ),
            TriviaQuestion(
                question: "What is a stop-loss order?",
                answers: [
                    TriviaAnswer(text: "An order to sell a stock when it reaches a certain price"),
                    TriviaAnswer(text: "An order to buy at any price"),
                    TriviaAnswer(text: "An order to buy only blue-chip stocks"),
                    TriviaAnswer(text: "An order to sell only at market close")
                ],
                correctIndex: 0,
                explanation: "A stop-loss order is an order to sell a stock when it reaches a certain price to limit losses."
            ),
            TriviaQuestion(
                question: "What is a margin account?",
                answers: [
                    TriviaAnswer(text: "An account that allows borrowing money to buy stocks"),
                    TriviaAnswer(text: "A savings account"),
                    TriviaAnswer(text: "A retirement account"),
                    TriviaAnswer(text: "A checking account")
                ],
                correctIndex: 0,
                explanation: "A margin account allows investors to borrow money to buy stocks."
            ),
            TriviaQuestion(
                question: "What is leverage?",
                answers: [
                    TriviaAnswer(text: "Using borrowed money to increase potential returns"),
                    TriviaAnswer(text: "Selling all stocks"),
                    TriviaAnswer(text: "Buying only bonds"),
                    TriviaAnswer(text: "A type of trading platform")
                ],
                correctIndex: 0,
                explanation: "Leverage is using borrowed money to increase potential returns on an investment."
            ),
            TriviaQuestion(
                question: "What is a stockbroker?",
                answers: [
                    TriviaAnswer(text: "A person or firm that buys and sells stocks on behalf of clients"),
                    TriviaAnswer(text: "A government official"),
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A trading strategy")
                ],
                correctIndex: 0,
                explanation: "A stockbroker is a person or firm that buys and sells stocks on behalf of clients."
            ),
        ]
    ),
    // Famous Companies
    TriviaChapter(
        title: "Famous Companies",
        icon: "building.2.crop.circle",
        color: .green,
        questions: [
            TriviaQuestion(
                question: "Which company is known as 'Big Blue'?",
                answers: [
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "IBM"),
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "Amazon")
                ],
                correctIndex: 1,
                explanation: "IBM is nicknamed 'Big Blue' due to its blue logo and branding."
            ),
            TriviaQuestion(
                question: "Which company created the iPhone?",
                answers: [
                    TriviaAnswer(text: "Google"),
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "Samsung"),
                    TriviaAnswer(text: "Microsoft")
                ],
                correctIndex: 1,
                explanation: "Apple created the iPhone, first released in 2007."
            ),
            TriviaQuestion(
                question: "Which company is the parent of YouTube?",
                answers: [
                    TriviaAnswer(text: "Facebook"),
                    TriviaAnswer(text: "Amazon"),
                    TriviaAnswer(text: "Google"),
                    TriviaAnswer(text: "Netflix")
                ],
                correctIndex: 2,
                explanation: "Google (now Alphabet Inc.) acquired YouTube in 2006."
            ),
            TriviaQuestion(
                question: "Which company is famous for its 'Prime' membership?",
                answers: [
                    TriviaAnswer(text: "Walmart"),
                    TriviaAnswer(text: "Amazon"),
                    TriviaAnswer(text: "Target"),
                    TriviaAnswer(text: "eBay")
                ],
                correctIndex: 1,
                explanation: "Amazon offers the 'Prime' membership program."
            ),
            TriviaQuestion(
                question: "Which company is known for the Windows operating system?",
                answers: [
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "IBM"),
                    TriviaAnswer(text: "Dell")
                ],
                correctIndex: 1,
                explanation: "Microsoft is known for the Windows operating system."
            ),
            TriviaQuestion(
                question: "Which company is the parent of Instagram?",
                answers: [
                    TriviaAnswer(text: "Twitter"),
                    TriviaAnswer(text: "Meta (Facebook)"),
                    TriviaAnswer(text: "Snapchat"),
                    TriviaAnswer(text: "Google")
                ],
                correctIndex: 1,
                explanation: "Meta Platforms (formerly Facebook) owns Instagram."
            ),
            TriviaQuestion(
                question: "Which company is known for the search engine 'Bing'?",
                answers: [
                    TriviaAnswer(text: "Google"),
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "Yahoo"),
                    TriviaAnswer(text: "Apple")
                ],
                correctIndex: 1,
                explanation: "Microsoft operates the Bing search engine."
            ),
            TriviaQuestion(
                question: "Which company is the world's largest retailer by revenue?",
                answers: [
                    TriviaAnswer(text: "Amazon"),
                    TriviaAnswer(text: "Walmart"),
                    TriviaAnswer(text: "Costco"),
                    TriviaAnswer(text: "Target")
                ],
                correctIndex: 1,
                explanation: "Walmart is the world's largest retailer by revenue."
            ),
            TriviaQuestion(
                question: "Which company is known for the electric car brand 'Model S'?",
                answers: [
                    TriviaAnswer(text: "Ford"),
                    TriviaAnswer(text: "Tesla"),
                    TriviaAnswer(text: "General Motors"),
                    TriviaAnswer(text: "Toyota")
                ],
                correctIndex: 1,
                explanation: "Tesla produces the Model S electric car."
            ),
            TriviaQuestion(
                question: "Which company is the parent of LinkedIn?",
                answers: [
                    TriviaAnswer(text: "Google"),
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "Meta (Facebook)"),
                    TriviaAnswer(text: "Amazon")
                ],
                correctIndex: 1,
                explanation: "Microsoft acquired LinkedIn in 2016."
            ),
            TriviaQuestion(
                question: "Which company is known for the PlayStation gaming console?",
                answers: [
                    TriviaAnswer(text: "Sony"),
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "Nintendo"),
                    TriviaAnswer(text: "Apple")
                ],
                correctIndex: 0,
                explanation: "Sony is the company behind the PlayStation gaming console."
            ),
            TriviaQuestion(
                question: "Which company is the parent of WhatsApp?",
                answers: [
                    TriviaAnswer(text: "Google"),
                    TriviaAnswer(text: "Meta (Facebook)"),
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "Microsoft")
                ],
                correctIndex: 1,
                explanation: "Meta Platforms (formerly Facebook) owns WhatsApp."
            ),
            TriviaQuestion(
                question: "Which company is known for the 'Galaxy' line of smartphones?",
                answers: [
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "Samsung"),
                    TriviaAnswer(text: "Google"),
                    TriviaAnswer(text: "Sony")
                ],
                correctIndex: 1,
                explanation: "Samsung produces the Galaxy line of smartphones."
            ),
            TriviaQuestion(
                question: "Which company is the parent of the streaming service Disney+?",
                answers: [
                    TriviaAnswer(text: "Netflix"),
                    TriviaAnswer(text: "Disney"),
                    TriviaAnswer(text: "Amazon"),
                    TriviaAnswer(text: "Apple")
                ],
                correctIndex: 1,
                explanation: "Disney owns the Disney+ streaming service."
            ),
            TriviaQuestion(
                question: "Which company is known for the 'Surface' line of computers?",
                answers: [
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "Dell"),
                    TriviaAnswer(text: "HP")
                ],
                correctIndex: 1,
                explanation: "Microsoft produces the Surface line of computers."
            ),
        ]
    ),
    // Stock Market History
    TriviaChapter(
        title: "Stock Market History",
        icon: "clock.arrow.circlepath",
        color: .orange,
        questions: [
            TriviaQuestion(
                question: "In what year did the Wall Street Crash, also known as Black Tuesday, occur?",
                answers: [
                    TriviaAnswer(text: "1929"),
                    TriviaAnswer(text: "1987"),
                    TriviaAnswer(text: "2008"),
                    TriviaAnswer(text: "1973")
                ],
                correctIndex: 0,
                explanation: "The Wall Street Crash happened in 1929, marking the start of the Great Depression."
            ),
            TriviaQuestion(
                question: "Which event is known as the 'Dot-com Bubble'?",
                answers: [
                    TriviaAnswer(text: "A surge in internet company stocks in the late 1990s"),
                    TriviaAnswer(text: "A crash in oil prices"),
                    TriviaAnswer(text: "A housing market collapse"),
                    TriviaAnswer(text: "A government shutdown")
                ],
                correctIndex: 0,
                explanation: "The Dot-com Bubble refers to the rapid rise and fall of internet company stocks in the late 1990s and early 2000s."
            ),
            TriviaQuestion(
                question: "What year did the financial crisis known as the 'Great Recession' begin?",
                answers: [
                    TriviaAnswer(text: "2001"),
                    TriviaAnswer(text: "2008"),
                    TriviaAnswer(text: "2012"),
                    TriviaAnswer(text: "1999")
                ],
                correctIndex: 1,
                explanation: "The Great Recession began in 2008 with the collapse of major financial institutions."
            ),
            TriviaQuestion(
                question: "Which company became the first to reach a $1 trillion market cap?",
                answers: [
                    TriviaAnswer(text: "Microsoft"),
                    TriviaAnswer(text: "Apple"),
                    TriviaAnswer(text: "Amazon"),
                    TriviaAnswer(text: "Google")
                ],
                correctIndex: 1,
                explanation: "Apple became the first company to reach a $1 trillion market cap in 2018."
            ),
            TriviaQuestion(
                question: "What was the main cause of the 2008 financial crisis?",
                answers: [
                    TriviaAnswer(text: "Subprime mortgage lending"),
                    TriviaAnswer(text: "Oil prices"),
                    TriviaAnswer(text: "Tech bubble"),
                    TriviaAnswer(text: "Trade war")
                ],
                correctIndex: 0,
                explanation: "The 2008 crisis was largely caused by subprime mortgage lending and the collapse of mortgage-backed securities."
            ),
            TriviaQuestion(
                question: "Which year did the 'Black Monday' stock market crash occur?",
                answers: [
                    TriviaAnswer(text: "1987"),
                    TriviaAnswer(text: "1929"),
                    TriviaAnswer(text: "2001"),
                    TriviaAnswer(text: "2010")
                ],
                correctIndex: 0,
                explanation: "Black Monday occurred on October 19, 1987, when stock markets crashed around the world."
            ),
            TriviaQuestion(
                question: "Which company was removed from the Dow Jones in 2018 after over 100 years?",
                answers: [
                    TriviaAnswer(text: "General Electric"),
                    TriviaAnswer(text: "IBM"),
                    TriviaAnswer(text: "ExxonMobil"),
                    TriviaAnswer(text: "Coca-Cola")
                ],
                correctIndex: 0,
                explanation: "General Electric was removed from the Dow Jones in 2018 after being a member for over 100 years."
            ),
            TriviaQuestion(
                question: "What is the oldest stock exchange in the world?",
                answers: [
                    TriviaAnswer(text: "New York Stock Exchange"),
                    TriviaAnswer(text: "London Stock Exchange"),
                    TriviaAnswer(text: "Amsterdam Stock Exchange"),
                    TriviaAnswer(text: "Tokyo Stock Exchange")
                ],
                correctIndex: 2,
                explanation: "The Amsterdam Stock Exchange, founded in 1602, is the oldest in the world."
            ),
            TriviaQuestion(
                question: "Which U.S. president signed the Securities Exchange Act of 1934?",
                answers: [
                    TriviaAnswer(text: "Franklin D. Roosevelt"),
                    TriviaAnswer(text: "Herbert Hoover"),
                    TriviaAnswer(text: "John F. Kennedy"),
                    TriviaAnswer(text: "Ronald Reagan")
                ],
                correctIndex: 0,
                explanation: "Franklin D. Roosevelt signed the Securities Exchange Act of 1934."
            ),
            TriviaQuestion(
                question: "What is the nickname for the 1990s stock market boom?",
                answers: [
                    TriviaAnswer(text: "Dot-com Boom"),
                    TriviaAnswer(text: "Roaring Twenties"),
                    TriviaAnswer(text: "Great Recession"),
                    TriviaAnswer(text: "Black Monday")
                ],
                correctIndex: 0,
                explanation: "The 1990s stock market boom is often called the Dot-com Boom."
            ),
            TriviaQuestion(
                question: "Which country experienced the 'Lost Decade' in its stock market during the 1990s?",
                answers: [
                    TriviaAnswer(text: "Japan"),
                    TriviaAnswer(text: "USA"),
                    TriviaAnswer(text: "Germany"),
                    TriviaAnswer(text: "Brazil")
                ],
                correctIndex: 0,
                explanation: "Japan experienced the 'Lost Decade' after its asset price bubble burst in the early 1990s."
            ),
        ]
    ),
    // Terminology
    TriviaChapter(
        title: "Terminology",
        icon: "text.book.closed",
        color: .purple,
        questions: [
            TriviaQuestion(
                question: "What does P/E ratio stand for?",
                answers: [
                    TriviaAnswer(text: "Price/Earnings Ratio"),
                    TriviaAnswer(text: "Profit/Equity Ratio"),
                    TriviaAnswer(text: "Price/Equity Ratio"),
                    TriviaAnswer(text: "Profit/Earnings Ratio")
                ],
                correctIndex: 0,
                explanation: "P/E ratio stands for Price/Earnings Ratio."
            ),
            TriviaQuestion(
                question: "What is liquidity?",
                answers: [
                    TriviaAnswer(text: "The amount of cash a company has"),
                    TriviaAnswer(text: "How easily an asset can be converted to cash"),
                    TriviaAnswer(text: "A company's profit margin"),
                    TriviaAnswer(text: "A type of investment")
                ],
                correctIndex: 1,
                explanation: "Liquidity refers to how easily an asset can be converted to cash."
            ),
            TriviaQuestion(
                question: "What does EPS stand for?",
                answers: [
                    TriviaAnswer(text: "Earnings Per Share"),
                    TriviaAnswer(text: "Equity Per Stock"),
                    TriviaAnswer(text: "Earnings Per Stock"),
                    TriviaAnswer(text: "Equity Per Share")
                ],
                correctIndex: 0,
                explanation: "EPS stands for Earnings Per Share."
            ),
            TriviaQuestion(
                question: "What is a bond?",
                answers: [
                    TriviaAnswer(text: "A loan made to a company or government"),
                    TriviaAnswer(text: "A type of stock"),
                    TriviaAnswer(text: "A trading strategy"),
                    TriviaAnswer(text: "A dividend payment")
                ],
                correctIndex: 0,
                explanation: "A bond is a loan made to a company or government by an investor."
            ),
            TriviaQuestion(
                question: "What is volatility?",
                answers: [
                    TriviaAnswer(text: "The degree of variation in a stock's price"),
                    TriviaAnswer(text: "The number of shares traded"),
                    TriviaAnswer(text: "The amount of dividends paid"),
                    TriviaAnswer(text: "The number of employees in a company")
                ],
                correctIndex: 0,
                explanation: "Volatility is the degree of variation in a stock's price over time."
            ),
            TriviaQuestion(
                question: "What is a bull?",
                answers: [
                    TriviaAnswer(text: "An investor who believes prices will rise"),
                    TriviaAnswer(text: "An investor who believes prices will fall"),
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A trading platform")
                ],
                correctIndex: 0,
                explanation: "A bull is an investor who believes prices will rise."
            ),
            TriviaQuestion(
                question: "What is a bear?",
                answers: [
                    TriviaAnswer(text: "An investor who believes prices will fall"),
                    TriviaAnswer(text: "An investor who believes prices will rise"),
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A trading platform")
                ],
                correctIndex: 0,
                explanation: "A bear is an investor who believes prices will fall."
            ),
            TriviaQuestion(
                question: "What is a sector?",
                answers: [
                    TriviaAnswer(text: "A group of stocks in the same industry"),
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A trading strategy"),
                    TriviaAnswer(text: "A government regulation")
                ],
                correctIndex: 0,
                explanation: "A sector is a group of stocks in the same industry."
            ),
            TriviaQuestion(
                question: "What is a yield?",
                answers: [
                    TriviaAnswer(text: "The income return on an investment"),
                    TriviaAnswer(text: "The number of shares traded"),
                    TriviaAnswer(text: "The amount of cash a company has"),
                    TriviaAnswer(text: "The number of employees in a company")
                ],
                correctIndex: 0,
                explanation: "Yield is the income return on an investment, such as interest or dividends."
            ),
            TriviaQuestion(
                question: "What is a capital gain?",
                answers: [
                    TriviaAnswer(text: "Profit from selling an asset at a higher price than bought"),
                    TriviaAnswer(text: "A type of bond"),
                    TriviaAnswer(text: "A trading strategy"),
                    TriviaAnswer(text: "A government tax")
                ],
                correctIndex: 0,
                explanation: "A capital gain is the profit from selling an asset at a higher price than it was bought."
            ),
            TriviaQuestion(
                question: "What is a public company?",
                answers: [
                    TriviaAnswer(text: "A company whose shares are traded on a stock exchange"),
                    TriviaAnswer(text: "A company owned by the government"),
                    TriviaAnswer(text: "A company with no shareholders"),
                    TriviaAnswer(text: "A company that pays no dividends")
                ],
                correctIndex: 0,
                explanation: "A public company is one whose shares are traded on a stock exchange."
            ),
            TriviaQuestion(
                question: "What is an index fund?",
                answers: [
                    TriviaAnswer(text: "A fund that tracks a specific market index"),
                    TriviaAnswer(text: "A fund that invests only in bonds"),
                    TriviaAnswer(text: "A fund managed by a single person"),
                    TriviaAnswer(text: "A fund that pays no dividends")
                ],
                correctIndex: 0,
                explanation: "An index fund is a fund that tracks a specific market index."
            ),
        ]
    ),
    // Trading Strategies
    TriviaChapter(
        title: "Trading Strategies",
        icon: "arrow.triangle.2.circlepath",
        color: .red,
        questions: [
            TriviaQuestion(
                question: "What is day trading?",
                answers: [
                    TriviaAnswer(text: "Buying and selling stocks within the same day"),
                    TriviaAnswer(text: "Holding stocks for years"),
                    TriviaAnswer(text: "Investing in mutual funds"),
                    TriviaAnswer(text: "Short selling only")
                ],
                correctIndex: 0,
                explanation: "Day trading involves buying and selling stocks within the same trading day."
            ),
            TriviaQuestion(
                question: "What is short selling?",
                answers: [
                    TriviaAnswer(text: "Selling stocks you don't own, hoping to buy them back at a lower price"),
                    TriviaAnswer(text: "Selling stocks for a profit"),
                    TriviaAnswer(text: "Selling stocks after a long period"),
                    TriviaAnswer(text: "Selling only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "Short selling is selling stocks you don't own, hoping to buy them back at a lower price."
            ),
            TriviaQuestion(
                question: "What is swing trading?",
                answers: [
                    TriviaAnswer(text: "Holding stocks for several days or weeks to profit from price swings"),
                    TriviaAnswer(text: "Buying and selling within the same day"),
                    TriviaAnswer(text: "Investing for retirement"),
                    TriviaAnswer(text: "Buying only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "Swing trading involves holding stocks for several days or weeks to profit from expected price swings."
            ),
            TriviaQuestion(
                question: "What is value investing?",
                answers: [
                    TriviaAnswer(text: "Investing in undervalued stocks"),
                    TriviaAnswer(text: "Investing in high-growth stocks"),
                    TriviaAnswer(text: "Day trading"),
                    TriviaAnswer(text: "Short selling only")
                ],
                correctIndex: 0,
                explanation: "Value investing is the strategy of investing in undervalued stocks."
            ),
            TriviaQuestion(
                question: "What is growth investing?",
                answers: [
                    TriviaAnswer(text: "Investing in companies expected to grow faster than the market"),
                    TriviaAnswer(text: "Investing in bonds"),
                    TriviaAnswer(text: "Short selling"),
                    TriviaAnswer(text: "Investing in only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "Growth investing focuses on companies expected to grow faster than the market average."
            ),
            TriviaQuestion(
                question: "What is momentum trading?",
                answers: [
                    TriviaAnswer(text: "Buying stocks that are rising and selling those that are falling"),
                    TriviaAnswer(text: "Buying only blue-chip stocks"),
                    TriviaAnswer(text: "Investing in bonds"),
                    TriviaAnswer(text: "Short selling only")
                ],
                correctIndex: 0,
                explanation: "Momentum trading involves buying stocks that are rising and selling those that are falling."
            ),
            TriviaQuestion(
                question: "What is a stop-limit order?",
                answers: [
                    TriviaAnswer(text: "An order that combines features of stop and limit orders"),
                    TriviaAnswer(text: "An order to buy at any price"),
                    TriviaAnswer(text: "An order to sell only at market close"),
                    TriviaAnswer(text: "An order to buy only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "A stop-limit order combines the features of stop and limit orders."
            ),
            TriviaQuestion(
                question: "What is position trading?",
                answers: [
                    TriviaAnswer(text: "Holding stocks for months or years"),
                    TriviaAnswer(text: "Buying and selling within the same day"),
                    TriviaAnswer(text: "Short selling only"),
                    TriviaAnswer(text: "Investing in only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "Position trading involves holding stocks for months or years."
            ),
            TriviaQuestion(
                question: "What is technical analysis?",
                answers: [
                    TriviaAnswer(text: "Analyzing price charts and patterns to make trading decisions"),
                    TriviaAnswer(text: "Analyzing company financials"),
                    TriviaAnswer(text: "Investing in bonds"),
                    TriviaAnswer(text: "Short selling only")
                ],
                correctIndex: 0,
                explanation: "Technical analysis is the study of price charts and patterns to make trading decisions."
            ),
            TriviaQuestion(
                question: "What is fundamental analysis?",
                answers: [
                    TriviaAnswer(text: "Analyzing a company's financial statements and health"),
                    TriviaAnswer(text: "Analyzing price charts"),
                    TriviaAnswer(text: "Short selling only"),
                    TriviaAnswer(text: "Investing in only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "Fundamental analysis involves analyzing a company's financial statements and health."
            ),
        ]
    ),
    // Indices
    TriviaChapter(
        title: "Indices",
        icon: "list.number",
        color: .teal,
        questions: [
            TriviaQuestion(
                question: "What does the S&P 500 index track?",
                answers: [
                    TriviaAnswer(text: "500 largest U.S. companies"),
                    TriviaAnswer(text: "All U.S. stocks"),
                    TriviaAnswer(text: "Top 30 U.S. companies"),
                    TriviaAnswer(text: "Only tech companies")
                ],
                correctIndex: 0,
                explanation: "The S&P 500 tracks the 500 largest U.S. companies by market cap."
            ),
            TriviaQuestion(
                question: "Which index is known as 'the Dow'?",
                answers: [
                    TriviaAnswer(text: "Dow Jones Industrial Average"),
                    TriviaAnswer(text: "NASDAQ"),
                    TriviaAnswer(text: "Russell 2000"),
                    TriviaAnswer(text: "FTSE 100")
                ],
                correctIndex: 0,
                explanation: "'The Dow' refers to the Dow Jones Industrial Average."
            ),
            TriviaQuestion(
                question: "Which index tracks technology companies?",
                answers: [
                    TriviaAnswer(text: "NASDAQ"),
                    TriviaAnswer(text: "S&P 500"),
                    TriviaAnswer(text: "Dow Jones"),
                    TriviaAnswer(text: "FTSE 100")
                ],
                correctIndex: 0,
                explanation: "NASDAQ is known for tracking technology companies."
            ),
            TriviaQuestion(
                question: "What does the FTSE 100 index represent?",
                answers: [
                    TriviaAnswer(text: "100 largest companies on the London Stock Exchange"),
                    TriviaAnswer(text: "100 largest U.S. companies"),
                    TriviaAnswer(text: "100 largest Japanese companies"),
                    TriviaAnswer(text: "100 largest Chinese companies")
                ],
                correctIndex: 0,
                explanation: "The FTSE 100 represents the 100 largest companies on the London Stock Exchange."
            ),
            TriviaQuestion(
                question: "Which index tracks small-cap U.S. companies?",
                answers: [
                    TriviaAnswer(text: "Russell 2000"),
                    TriviaAnswer(text: "S&P 500"),
                    TriviaAnswer(text: "Dow Jones"),
                    TriviaAnswer(text: "NASDAQ")
                ],
                correctIndex: 0,
                explanation: "The Russell 2000 tracks small-cap U.S. companies."
            ),
            TriviaQuestion(
                question: "Which index is often used as a benchmark for the U.S. stock market?",
                answers: [
                    TriviaAnswer(text: "S&P 500"),
                    TriviaAnswer(text: "FTSE 100"),
                    TriviaAnswer(text: "Nikkei 225"),
                    TriviaAnswer(text: "DAX")
                ],
                correctIndex: 0,
                explanation: "The S&P 500 is often used as a benchmark for the U.S. stock market."
            ),
            TriviaQuestion(
                question: "What does the Nikkei 225 index track?",
                answers: [
                    TriviaAnswer(text: "225 leading companies on the Tokyo Stock Exchange"),
                    TriviaAnswer(text: "225 leading companies on the NYSE"),
                    TriviaAnswer(text: "225 leading companies on the LSE"),
                    TriviaAnswer(text: "225 leading companies on the NASDAQ")
                ],
                correctIndex: 0,
                explanation: "The Nikkei 225 tracks 225 leading companies on the Tokyo Stock Exchange."
            ),
        ]
    ),
    // Famous Investors
    TriviaChapter(
        title: "Famous Investors",
        icon: "person.crop.circle.badge.checkmark.fill",
        color: .yellow,
        questions: [
            TriviaQuestion(
                question: "Who is known as the 'Oracle of Omaha'?",
                answers: [
                    TriviaAnswer(text: "Elon Musk"),
                    TriviaAnswer(text: "Warren Buffett"),
                    TriviaAnswer(text: "Bill Gates"),
                    TriviaAnswer(text: "Peter Lynch")
                ],
                correctIndex: 1,
                explanation: "Warren Buffett is known as the 'Oracle of Omaha'."
            ),
            TriviaQuestion(
                question: "Who founded Bridgewater Associates?",
                answers: [
                    TriviaAnswer(text: "Ray Dalio"),
                    TriviaAnswer(text: "George Soros"),
                    TriviaAnswer(text: "Carl Icahn"),
                    TriviaAnswer(text: "Benjamin Graham")
                ],
                correctIndex: 0,
                explanation: "Ray Dalio founded Bridgewater Associates."
            ),
            TriviaQuestion(
                question: "Who wrote 'The Intelligent Investor'?",
                answers: [
                    TriviaAnswer(text: "Benjamin Graham"),
                    TriviaAnswer(text: "Warren Buffett"),
                    TriviaAnswer(text: "Peter Lynch"),
                    TriviaAnswer(text: "Ray Dalio")
                ],
                correctIndex: 0,
                explanation: "Benjamin Graham wrote 'The Intelligent Investor'."
            ),
            TriviaQuestion(
                question: "Who is the founder of Vanguard Group?",
                answers: [
                    TriviaAnswer(text: "John C. Bogle"),
                    TriviaAnswer(text: "Warren Buffett"),
                    TriviaAnswer(text: "Ray Dalio"),
                    TriviaAnswer(text: "George Soros")
                ],
                correctIndex: 0,
                explanation: "John C. Bogle founded Vanguard Group."
            ),
            TriviaQuestion(
                question: "Who is known for the 'Magellan Fund'?",
                answers: [
                    TriviaAnswer(text: "Peter Lynch"),
                    TriviaAnswer(text: "Warren Buffett"),
                    TriviaAnswer(text: "Ray Dalio"),
                    TriviaAnswer(text: "Carl Icahn")
                ],
                correctIndex: 0,
                explanation: "Peter Lynch managed the Magellan Fund at Fidelity."
            ),
            TriviaQuestion(
                question: "Who is the founder of Tesla and SpaceX?",
                answers: [
                    TriviaAnswer(text: "Elon Musk"),
                    TriviaAnswer(text: "Jeff Bezos"),
                    TriviaAnswer(text: "Bill Gates"),
                    TriviaAnswer(text: "Warren Buffett")
                ],
                correctIndex: 0,
                explanation: "Elon Musk is the founder of Tesla and SpaceX."
            ),
            TriviaQuestion(
                question: "Who is known for breaking the Bank of England?",
                answers: [
                    TriviaAnswer(text: "George Soros"),
                    TriviaAnswer(text: "Ray Dalio"),
                    TriviaAnswer(text: "Carl Icahn"),
                    TriviaAnswer(text: "John Paulson")
                ],
                correctIndex: 0,
                explanation: "George Soros is known for breaking the Bank of England in 1992."
            ),
            TriviaQuestion(
                question: "Who is the founder of Amazon?",
                answers: [
                    TriviaAnswer(text: "Jeff Bezos"),
                    TriviaAnswer(text: "Elon Musk"),
                    TriviaAnswer(text: "Bill Gates"),
                    TriviaAnswer(text: "Warren Buffett")
                ],
                correctIndex: 0,
                explanation: "Jeff Bezos founded Amazon in 1994."
            ),
        ]
    ),
    // Miscellaneous
    TriviaChapter(
        title: "Miscellaneous",
        icon: "questionmark.circle",
        color: .gray,
        questions: [
            TriviaQuestion(
                question: "What is the main U.S. regulator for securities markets?",
                answers: [
                    TriviaAnswer(text: "SEC"),
                    TriviaAnswer(text: "FBI"),
                    TriviaAnswer(text: "IRS"),
                    TriviaAnswer(text: "CIA")
                ],
                correctIndex: 0,
                explanation: "The SEC (Securities and Exchange Commission) regulates U.S. securities markets."
            ),
            TriviaQuestion(
                question: "What is an ETF?",
                answers: [
                    TriviaAnswer(text: "Exchange-Traded Fund"),
                    TriviaAnswer(text: "Electronic Transfer Fee"),
                    TriviaAnswer(text: "Equity Trading Firm"),
                    TriviaAnswer(text: "Earnings To Fund")
                ],
                correctIndex: 0,
                explanation: "ETF stands for Exchange-Traded Fund."
            ),
            TriviaQuestion(
                question: "What is an ADR?",
                answers: [
                    TriviaAnswer(text: "American Depositary Receipt"),
                    TriviaAnswer(text: "Annual Dividend Rate"),
                    TriviaAnswer(text: "Asset Debt Ratio"),
                    TriviaAnswer(text: "Average Daily Return")
                ],
                correctIndex: 0,
                explanation: "ADR stands for American Depositary Receipt, a way for U.S. investors to own foreign stocks."
            ),
            TriviaQuestion(
                question: "What is a REIT?",
                answers: [
                    TriviaAnswer(text: "Real Estate Investment Trust"),
                    TriviaAnswer(text: "Retail Equity Investment Trust"),
                    TriviaAnswer(text: "Real Estate Income Tax"),
                    TriviaAnswer(text: "Retail Earnings Investment Trust")
                ],
                correctIndex: 0,
                explanation: "REIT stands for Real Estate Investment Trust."
            ),
            TriviaQuestion(
                question: "What is a 401(k)?",
                answers: [
                    TriviaAnswer(text: "A retirement savings plan"),
                    TriviaAnswer(text: "A type of stock"),
                    TriviaAnswer(text: "A government bond"),
                    TriviaAnswer(text: "A trading platform")
                ],
                correctIndex: 0,
                explanation: "A 401(k) is a retirement savings plan sponsored by an employer."
            ),
            TriviaQuestion(
                question: "What is an IPO lock-up period?",
                answers: [
                    TriviaAnswer(text: "A period after an IPO when insiders can't sell shares"),
                    TriviaAnswer(text: "A period when trading is halted"),
                    TriviaAnswer(text: "A period when dividends are paid"),
                    TriviaAnswer(text: "A period when only institutional investors can buy")
                ],
                correctIndex: 0,
                explanation: "An IPO lock-up period is a set time after an IPO when insiders can't sell their shares."
            ),
            TriviaQuestion(
                question: "What is a circuit breaker in stock trading?",
                answers: [
                    TriviaAnswer(text: "A mechanism to temporarily halt trading during large market drops"),
                    TriviaAnswer(text: "A device used in trading computers"),
                    TriviaAnswer(text: "A type of trading strategy"),
                    TriviaAnswer(text: "A government regulation on dividends")
                ],
                correctIndex: 0,
                explanation: "A circuit breaker temporarily halts trading during large market drops to prevent panic selling."
            ),
            TriviaQuestion(
                question: "What is insider trading?",
                answers: [
                    TriviaAnswer(text: "Trading based on non-public, material information"),
                    TriviaAnswer(text: "Trading only with family members"),
                    TriviaAnswer(text: "Trading on the NYSE"),
                    TriviaAnswer(text: "Trading only blue-chip stocks")
                ],
                correctIndex: 0,
                explanation: "Insider trading is trading based on non-public, material information."
            ),
            TriviaQuestion(
                question: "What is a stock buyback?",
                answers: [
                    TriviaAnswer(text: "When a company buys its own shares from the market"),
                    TriviaAnswer(text: "When an investor buys back shares"),
                    TriviaAnswer(text: "When a company issues new shares"),
                    TriviaAnswer(text: "When a company pays dividends")
                ],
                correctIndex: 0,
                explanation: "A stock buyback is when a company buys its own shares from the market."
            ),
            TriviaQuestion(
                question: "What is a SPAC?",
                answers: [
                    TriviaAnswer(text: "Special Purpose Acquisition Company"),
                    TriviaAnswer(text: "Stock Price Adjustment Clause"),
                    TriviaAnswer(text: "Shareholder Protection and Compensation"),
                    TriviaAnswer(text: "Securities and Public Accounting Commission")
                ],
                correctIndex: 0,
                explanation: "SPAC stands for Special Purpose Acquisition Company."
            ),
        ]
    )
]

class TriviaViewModel: ObservableObject {
    @Published var selectedChapter: TriviaChapter? = nil
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var showResult: Bool = false
    @Published var score: Int = 0
    @Published var showSummary: Bool = false
    @AppStorage("triviaHighScores") private var highScoresData: Data = Data()
    @Published var highScores: [String: Int] = [:] // [chapterTitle: highScore]
    
    init() {
        loadHighScores()
    }
    
    func startChapter(_ chapter: TriviaChapter) {
        selectedChapter = chapter
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        showResult = false
        score = 0
        showSummary = false
    }
    
    func answer(_ index: Int) {
        guard let chapter = selectedChapter else { return }
        selectedAnswerIndex = index
        showResult = true
        if index == chapter.questions[currentQuestionIndex].correctIndex {
            score += 1
        }
    }
    
    func nextQuestion() {
        guard let chapter = selectedChapter else { return }
        if currentQuestionIndex + 1 < chapter.questions.count {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            showResult = false
        } else {
            showSummary = true
            updateHighScore(for: chapter)
        }
    }
    
    func restartChapter() {
        if let chapter = selectedChapter {
            startChapter(chapter)
        }
    }
    
    private func updateHighScore(for chapter: TriviaChapter) {
        let key = chapter.title
        if score > (highScores[key] ?? 0) {
            highScores[key] = score
            saveHighScores()
        }
    }
    
    private func saveHighScores() {
        if let data = try? JSONEncoder().encode(highScores) {
            highScoresData = data
        }
    }
    
    private func loadHighScores() {
        if let loaded = try? JSONDecoder().decode([String: Int].self, from: highScoresData) {
            highScores = loaded
        }
    }
}

// MARK: - Main View
struct StocksTriviaView: View {
    @StateObject private var viewModel = TriviaViewModel()
    
    var body: some View {
        NavigationStack {
            if let chapter = viewModel.selectedChapter {
                if viewModel.showSummary {
                    TriviaSummaryView(viewModel: viewModel, chapter: chapter)
                } else {
                    TriviaGameView(viewModel: viewModel, chapter: chapter)
                }
            } else {
                TriviaLandingView(viewModel: viewModel)
            }
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Landing Page
struct TriviaLandingView: View {
    @ObservedObject var viewModel: TriviaViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Test your knowledge and climb the leaderboard! Choose a chapter to begin.")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                ForEach(sampleChapters) { chapter in
                    Button {
                        withAnimation {
                            viewModel.startChapter(chapter)
                        }
                    } label: {
                        HStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(chapter.color.opacity(0.15))
                                    .frame(width: 60, height: 60)
                                Image(systemName: chapter.icon)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(chapter.color)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(chapter.title)
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                Text("High Score: \(viewModel.highScores[chapter.title] ?? 0)/\(chapter.questions.count)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: chapter.color.opacity(0.08), radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Start \(chapter.title) trivia. High score: \(viewModel.highScores[chapter.title] ?? 0) out of \(chapter.questions.count)")
                }
            }
            .padding()
            .navigationTitle("Stocks Trivia")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color(.systemBackground))
    }
}

struct TriviaGameView: View {
    @ObservedObject var viewModel: TriviaViewModel
    let chapter: TriviaChapter
    @State private var localSelectedIndex: Int? = nil
    @State private var hasSubmitted: Bool = false
    
    var body: some View {
        let question = chapter.questions[viewModel.currentQuestionIndex]
        let enumeratedAnswers = Array(question.answers.enumerated())
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Text(chapter.title)
                    .font(.title2.bold())
                    .foregroundColor(chapter.color)
                ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(chapter.questions.count))
                    .accentColor(chapter.color)
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(chapter.questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 20) {
                Text(question.question)
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                ForEach(enumeratedAnswers, id: \.offset) { idx, answer in
                    Button {
                        if !hasSubmitted {
                            localSelectedIndex = idx
                        }
                    } label: {
                        HStack {
                            Text(answer.text)
                                .font(.title3)
                                .foregroundColor(.primary)
                                .padding(.vertical, 24)
                                .padding(.horizontal, 24)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            ZStack {
                                if hasSubmitted {
                                    if idx == question.correctIndex {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .padding(8)
                                    } else if idx == localSelectedIndex {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .padding(8)
                                    } else {
                                        Color.clear.frame(width: 40, height: 40)
                                    }
                                } else {
                                    Color.clear.frame(width: 40, height: 40)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 64)
                        .background(
                            ZStack {
                                if hasSubmitted {
                                    if idx == question.correctIndex {
                                        RoundedRectangle(cornerRadius: 20).fill(Color.green.opacity(0.5))
                                    } else if idx == localSelectedIndex {
                                        RoundedRectangle(cornerRadius: 20).fill(Color.red.opacity(0.5))
                                    } else {
                                        RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemBackground))
                                    }
                                } else {
                                    RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemBackground))
                                }
                            }
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .overlay(
                            Group {
                                if hasSubmitted {
                                    if idx == question.correctIndex {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.green, lineWidth: localSelectedIndex == idx ? 3 : 0)
                                    } else if idx == localSelectedIndex {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.red, lineWidth: 3)
                                    } else {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.clear, lineWidth: 0)
                                    }
                                } else {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(localSelectedIndex == idx ? chapter.color : Color.clear, lineWidth: localSelectedIndex == idx ? 2 : 0)
                                }
                            }
                        )
                        .animation(.easeInOut, value: hasSubmitted)
                    }
                    .disabled(hasSubmitted)
                    .accessibilityLabel(answer.text + (idx == question.correctIndex ? ", correct answer" : ""))
                }
                if hasSubmitted, let selected = localSelectedIndex, selected != question.correctIndex, let explanation = question.explanation {
                    Text(explanation)
                        .font(.body)
                        .foregroundColor(.orange)
                        .padding(.top, 12)
                        .accessibilityLabel("Explanation: \(explanation)")
                }
            }
            Spacer()
            if !hasSubmitted {
                Button(action: {
                    if let idx = localSelectedIndex {
                        viewModel.answer(idx)
                        hasSubmitted = true
                    }
                }) {
                    Text("Submit Answer")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(localSelectedIndex != nil ? chapter.color : Color(.systemGray4))
                        .foregroundColor(localSelectedIndex != nil ? .white : .gray)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                .disabled(localSelectedIndex == nil)
            } else {
                Button(action: {
                    viewModel.nextQuestion()
                    localSelectedIndex = nil
                    hasSubmitted = false
                }) {
                    Text(viewModel.currentQuestionIndex + 1 == chapter.questions.count ? "See Results" : "Next Question")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray3))
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .navigationTitle(chapter.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TriviaSummaryView: View {
    @ObservedObject var viewModel: TriviaViewModel
    let chapter: TriviaChapter
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Text("Chapter Complete!")
                    .font(.largeTitle.bold())
                    .foregroundColor(chapter.color)
                Text("Your Score: \(viewModel.score)/\(chapter.questions.count)")
                    .font(.title2)
                    .foregroundColor(.primary)
                if let high = viewModel.highScores[chapter.title], high == viewModel.score {
                    Text("🎉 New High Score!")
                        .font(.title3)
                        .foregroundColor(.green)
                } else {
                    Text("High Score: \(viewModel.highScores[chapter.title] ?? 0)/\(chapter.questions.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.restartChapter()
                }) {
                    Label("Retry", systemImage: "arrow.clockwise")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(chapter.color)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                Button(action: {
                    withAnimation {
                        viewModel.selectedChapter = nil
                    }
                }) {
                    Label("Back to Chapters", systemImage: "list.bullet")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .foregroundColor(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .navigationTitle(chapter.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
