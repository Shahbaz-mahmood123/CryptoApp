//
//  PolygonModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-12.
//

import Foundation


struct DailyOpenClose: Codable, Hashable {
    let symbol: String
    let isUTC: Bool
    let day: String
    let responseOpen: Double
    let close: Double
    let openTrades: [Trade]
    let closingTrades: [Trade]
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case isUTC = "isUTC"
        case day = "day"
        case responseOpen = "open"
        case close = "close"
        case openTrades = "openTrades"
        case closingTrades = "closingTrades"
    }
}


// MARK: - Trade
struct Trade: Codable, Hashable{
    let exchange: Int
    let tradePrice: Double
    let tradeSize: Double
    let conditionCodes: [Int]?
    let i: String?
    let timeStamp: Int?
    
    enum CodingKeys: String, CodingKey {
        case exchange = "x"
        case tradePrice = "p"
        case tradeSize = "s"
        case conditionCodes = "c"
        case i = "i"
        case timeStamp = "t"
    }
}
struct CryptoResponse: Codable {
    let ticker: String
    let queryCount: Int
    let resultsCount: Int
    let adjusted: Bool
    let results: [Result]
    let status: String
    // let requestID: String
    let count: Int
}

struct Result: Codable {
    let v: Double
    let vw: Double
    let o: Double
    let c: Double
    let h: Double
    let l: Double
    let t: Int
    let n: Int
}

struct CurrentMarketStatus: Codable {
    let market: String
    let earlyHours: Bool
    let afterHours: Bool
    let serverTime: String
    let exchanges: Exchanges
    let currencies: Currencies
}

// MARK: - Currencies
struct Currencies: Codable {
    let fx: String
    let crypto: String
}

// MARK: - Exchanges
struct Exchanges: Codable {
    let nyse: String
    let nasdaq: String
    let otc: String
}



#if DEBUG

extension DailyOpenClose {
    
    
    static var example: DailyOpenClose {
        DailyOpenClose(
            symbol: "BTC-USD",
            isUTC: true,
            day: "2020-10-14T00:00:00Z",
            responseOpen: 11443,
            close: 11427.7,
            openTrades: [openTrade],
            closingTrades: [closedTrade]
        )
        
    }
    
    static var openTrade: Trade{
        Trade(
            exchange: 2,
            tradePrice: 11443,
            tradeSize: 0.28057044,
            conditionCodes: [2],
            i: "511235750",
            timeStamp: 160263360008
            
        )
        
    }
    
    static var closedTrade: Trade{
        Trade (
            exchange: 1,
            tradePrice: 11427.7,
            tradeSize: 0.00278713,
            conditionCodes:[1],
            i: "105717894",
            timeStamp: 1602719999498)
    }
    
}

#endif
