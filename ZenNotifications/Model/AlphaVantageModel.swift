//
//  AlphaVantageModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-19.
//

import Foundation

struct ExchangeRate: Codable, Identifiable{
    let realtimeCurrencyExchangeRate: RealtimeCurrencyExchangeRate
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case realtimeCurrencyExchangeRate = "Realtime Currency Exchange Rate"
    }
}

// MARK: - RealtimeCurrencyExchangeRate
struct RealtimeCurrencyExchangeRate: Codable, Identifiable{
    let id = UUID()
    var the1FromCurrencyCode: String?
    var the2FromCurrencyName: String?
    var the3ToCurrencyCode: String?
    var the4ToCurrencyName: String?
    var the5ExchangeRate: String
    var the6LastRefreshed: String?
    var the7TimeZone: String?
    var the8BidPrice: String?
    var the9AskPrice: String?
    

    enum CodingKeys: String, CodingKey {
        case the1FromCurrencyCode = "1. From_Currency Code"
        case the2FromCurrencyName = "2. From_Currency Name"
        case the3ToCurrencyCode = "3. To_Currency Code"
        case the4ToCurrencyName = "4. To_Currency Name"
        case the5ExchangeRate = "5. Exchange Rate"
        case the6LastRefreshed = "6. Last Refreshed"
        case the7TimeZone = "7. Time Zone"
        case the8BidPrice = "8. Bid Price"
        case the9AskPrice = "9. Ask Price"
    }
}

struct HistoricalDailyData: Codable {
    let metaData: MetaData
    let timeSeriesDigitalCurrencyDaily: [String: TimeSeriesDigitalCurrencyDaily]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDigitalCurrencyDaily = "Time Series (Digital Currency Daily)"
    }
}

// MARK: - MetaData
struct MetaData: Codable{
    let the1Information: String
    let the2DigitalCurrencyCode: String
    let the3DigitalCurrencyName: String
    let the4MarketCode: String
    let the5MarketName: String
    let the6LastRefreshed: String
    let the7TimeZone: String
    
    
    enum CodingKeys: String, CodingKey {
        case the1Information = "1. Information"
        case the2DigitalCurrencyCode = "2. Digital Currency Code"
        case the3DigitalCurrencyName = "3. Digital Currency Name"
        case the4MarketCode = "4. Market Code"
        case the5MarketName = "5. Market Name"
        case the6LastRefreshed = "6. Last Refreshed"
        case the7TimeZone = "7. Time Zone"
    }
}

struct TimeSeriesDigitalCurrencyDaily: Codable {
    let the1AOpenCAD: String
    let the1BOpenUSD: String
    let the2AHighCAD: String
    let the2BHighUSD: String
    let the3ALowCAD: String
    let the3BLowUSD: String
    let the4ACloseCAD: String
    let the4BCloseUSD: String
    let the5Volume: String
    let the6MarketCapUSD: String

    enum CodingKeys: String, CodingKey {
        case the1AOpenCAD = "1a. open (CAD)"
        case the1BOpenUSD = "1b. open (USD)"
        case the2AHighCAD = "2a. high (CAD)"
        case the2BHighUSD = "2b. high (USD)"
        case the3ALowCAD = "3a. low (CAD)"
        case the3BLowUSD = "3b. low (USD)"
        case the4ACloseCAD = "4a. close (CAD)"
        case the4BCloseUSD = "4b. close (USD)"
        case the5Volume = "5. volume"
        case the6MarketCapUSD = "6. market cap (USD)"
    }
}
