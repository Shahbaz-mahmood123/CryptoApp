//
//  CryptoService.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-02-01.
//

import Foundation


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

struct ExchangeRate: Codable{
    let realtimeCurrencyExchangeRate: RealtimeCurrencyExchangeRate
    
    enum CodingKeys: String, CodingKey {
        case realtimeCurrencyExchangeRate = "Realtime Currency Exchange Rate"
    }
}

// MARK: - RealtimeCurrencyExchangeRate
struct RealtimeCurrencyExchangeRate: Codable {
    var the1FromCurrencyCode: String?
    var the2FromCurrencyName: String?
    var the3ToCurrencyCode: String?
    var the4ToCurrencyName: String?
    var the5ExchangeRate: String?
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



class CryptoService{
    
    @Published var cryptoResponse = CryptoResponse.self
    @Published var exhangeRate = ExchangeRate.self
    @Published var dailyData = HistoricalDailyData.self
    
    var polygonKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "PolygonAPIKey") as? String else {
          fatalError("Couldn't find key 'PolygonAPIKey' in 'Info.plist'.")
        }
        return value
      }
    }
    var AlphaVantage: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "AlphaVantageAPIKey") as? String else {
          fatalError("Couldn't find key 'AlphaVantageAPIKey' in 'Info.plist'.")
        }
        return value
      }
    }
        
    func getCryptoData(completion:@escaping (CryptoResponse) -> ()){
        

       // let token = Bundle.main.object(forInfoDictionaryKey: "PolygonAPIKey") as? String
        //let token = "u0zj42eqwtsYSt4NhYp1uwFXD_pA3YSg"
        let url = URL(string:"https://api.polygon.io/v2/aggs/ticker/X:BTCUSD/range/1/day/2021-07-22/2021-07-22")!
        
        var request = URLRequest(url: url)
        //request.httpMethod = "GET"
        
        request.setValue( "Bearer \(polygonKey)", forHTTPHeaderField: "Authorization")
        
        //execute post request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            print(data)
           
            let cryptoData = try! JSONDecoder().decode(CryptoResponse.self, from: data)
            print(cryptoData)
            
            DispatchQueue.main.async{
                completion(cryptoData)
            }
            
        }
        task.resume()
    }
    
    func getExchangeRate(completion: @escaping(ExchangeRate) -> ()){
        
        let exchangeRateURL = URL(string:"https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=BTC&to_currency=CAD&apikey=\(AlphaVantage)")!
        
        let request = URLRequest(url: exchangeRateURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            print(data)
            let exchangeRate = try! JSONDecoder().decode(ExchangeRate.self, from: data)
            print(exchangeRate)
            
            DispatchQueue.main.async{
                completion(exchangeRate)
            }
            
        }
        task.resume()
        
    }
    func getHistoricalDataDaily(completion: @escaping(HistoricalDailyData) -> ()){
        
        let dailyDataURL = URL(string:"https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=BTC&market=CNY&apikey=\(AlphaVantage)")!
        
        let request = URLRequest(url: dailyDataURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

           print(data)
            let dailyData = try! JSONDecoder().decode(HistoricalDailyData.self, from: data)
            print(dailyData)
            
            DispatchQueue.main.async{
                completion(dailyData)
            }
            
        }
        task.resume()
        
    }
}

