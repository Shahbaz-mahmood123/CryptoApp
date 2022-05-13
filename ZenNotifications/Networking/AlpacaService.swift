//
//  AlpacaService.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-05.
//

import Foundation


class AlpacaService: ObservableObject {
    var alpacaApiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "AlpacaAPIKey") as? String else {
          fatalError("Couldn't find key 'AlpacaAPIKey' in 'Info.plist'.")
        }
        return value
      }
    }
    var alpacaSecretKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "AlpacaSecretKey") as? String else {
          fatalError("Couldn't find key 'AlpacaSecretKey' in 'Info.plist'.")
        }
        return value
      }
    }

    
    func getnews(completion: @escaping (NewsResponse) -> Void ){
        
        let url = URL(string:"https://data.alpaca.markets/v1beta1/news")!
        
        var request = URLRequest(url: url)
        
        request.setValue(alpacaApiKey, forHTTPHeaderField: "APCA-API-KEY-ID")
        request.setValue(alpacaSecretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //assign data to variable to return via completion handler
            let newsResponse = try! JSONDecoder().decode(NewsResponse.self, from: data)
            
            print(newsResponse)
            DispatchQueue.main.async {
                completion(newsResponse)
            }
        }
        task.resume()
        
        
    }
    
    func getExchangePrice(exchange: String,completion: @escaping (ExchangeResponse) -> Void){
        let url = URL(string:"https://data.alpaca.markets/v1beta1/crypto/btcusd/quotes/latest?exchange=\(exchange)")!
        
        var request = URLRequest(url: url)
        
        request.setValue(alpacaApiKey, forHTTPHeaderField: "APCA-API-KEY-ID")
        request.setValue(alpacaSecretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //assign data to variable to return via completion handler
            let exchangeResponse = try! JSONDecoder().decode(ExchangeResponse.self, from: data)
           
            DispatchQueue.main.async {
                completion(exchangeResponse)
            }
        }
        task.resume()
        
    }
    
    func getBars(crypto: String,completion: @escaping (BarResponse) -> Void){
        let url = URL(string:"https://data.alpaca.markets/v1beta1/crypto/\(crypto)/bars?start=2021-04-01T00:00:00Z&timeframe=1Day")!
        
        var request = URLRequest(url: url)
        
        request.setValue(alpacaApiKey, forHTTPHeaderField: "APCA-API-KEY-ID")
        request.setValue(alpacaSecretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //assign data to variable to return via completion handler
            let barResponse = try! JSONDecoder().decode(BarResponse.self, from: data)
           
            DispatchQueue.main.async {
                completion(barResponse)
            }
        }
        task.resume()
    }
    
    func getRecentTrades(completion: @escaping(RecentTradeResponse) -> Void){
        let url = URL(string:"https://data.alpaca.markets/v1beta1/crypto/BTCUSD/trades?limit=25")!
        
        var request = URLRequest(url: url)
        
        request.setValue(alpacaApiKey, forHTTPHeaderField: "APCA-API-KEY-ID")
        request.setValue(alpacaSecretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //assign data to variable to return via completion handler
            let recentTradeResponse = try! JSONDecoder().decode(RecentTradeResponse.self, from: data)
           
            DispatchQueue.main.async {
                completion(recentTradeResponse)
            }
        }
        task.resume()
    }
    
    func getLineChartData() async throws {
        guard let url = URL(string: "https://data.alpaca.markets/v1beta1/crypto/BTCUSD/trades?limit=25") else { fatalError("Missing URL") }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(alpacaApiKey, forHTTPHeaderField: "APCA-API-KEY-ID")
            urlRequest.setValue(alpacaSecretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
        
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let recentTradeResponse = try JSONDecoder().decode(RecentTradeResponse.self, from: data)
        print("Async trade response", recentTradeResponse)
    }
}
