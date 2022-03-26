//
//  AlpacaModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-19.
//

import Foundation

struct NewsResponse: Codable {
    let news: [News]
    let nextPageToken: String

    enum CodingKeys: String, CodingKey {
        case news = "news"
        case nextPageToken = "next_page_token"
    }
}

// MARK: - News
struct News: Codable, Identifiable {
    let id: Int
    let headline: String
    let author: String
    let createdAt: String
    let updatedAt: String
    let summary: String
    let url: String
    let images: [NewsImage]
    let symbols: [String]
    let source: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case headline = "headline"
        case author = "author"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case summary = "summary"
        case url = "url"
        case images = "images"
        case symbols = "symbols"
        case source = "source"
    }
}

struct NewsImage: Codable, Identifiable {
    let size: Size
    let url: String
    let id: UUID?

    enum CodingKeys: String, CodingKey {
        case size = "size"
        case url = "url"
        case id = "id"
    }
}

enum Size: String, Codable {
    case large = "large"
    case small = "small"
    case thumb = "thumb"
}


// MARK: - Response
struct ExchangeResponse: Codable, Identifiable {
    let id: UUID?
    let symbol: String
    let quote: Quote
}

// MARK: - Quote
struct Quote: Codable {
    let timestamp: String?
    let exchange: String
    let bidPrice: Double
    let bidSize: Double
    let askPrice: Double
    let askSize: Double

    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case exchange = "x"
        case bidPrice = "bp"
        case bidSize = "bs"
        case askPrice = "ap"
        case askSize = "as"
    }
}


struct BarResponse: Codable, Identifiable {
    let id: UUID?
    let bars: [Bar]
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case bars = "bars"
        case symbol = "symbol"
        case id = "id"
    }
}

// MARK: - Bar
struct Bar: Codable {
    let timestamp: String
    let exchangeCode: ExchangeName
    let openPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let closePrice: Double
    let volume: Double
    let numberOfTrades: Int
    let volumneWeightedperAverage: Double

    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case exchangeCode = "x"
        case openPrice = "o"
        case highPrice = "h"
        case lowPrice = "l"
        case closePrice = "c"
        case volume = "v"
        case numberOfTrades = "n"
        case volumneWeightedperAverage = "vw"
    }
}

enum ExchangeName: String, Codable {
    case cbse = "CBSE"
    case ersx = "ERSX"
    case ftxu = "FTXU"
}

struct RecentTradeResponse: Codable, Identifiable {
    var id: UUID?
    let trades: [RecentTrade]
    let symbol: String
    let nextPageToken: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case trades = "trades"
        case symbol = "symbol"
        case nextPageToken = "next_page_token"
    }
}

// MARK: - Trade
struct RecentTrade: Codable {
    let timestamp: String
    let exchange: String
    let tradePrice: Double
    let tradeSize: Double
    let tks: String
    let tradeId: Int

    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case exchange = "x"
        case tradePrice = "p"
        case tradeSize = "s"
        case tks = "tks"
        case tradeId = "i"
    }
}




