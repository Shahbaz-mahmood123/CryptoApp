//
//  AlphaVantage.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-19.
//

import Foundation



class AlphaVantageService: ObservableObject{
    private var AlphaVantage: String {
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
    
    func getExchangeRate(cryptoSymbol: String,completion: @escaping(ExchangeRate) -> ()){

        let exchangeRateURL = URL(string:"https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(cryptoSymbol)&to_currency=CAD&apikey=\(AlphaVantage)")!
        
        let request = URLRequest(url: exchangeRateURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
       
            let exchangeRate = try! JSONDecoder().decode(ExchangeRate.self, from: data)
            
            DispatchQueue.main.async{
                completion(exchangeRate)
            }
            
        }
        task.resume()
        
    }
    func getHistoricalDataDaily(completion: @escaping(HistoricalDailyData) -> ()){
        
        let dailyDataURL = URL(string:"https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=BTC&market=CAD&apikey=\(AlphaVantage)")!
        
        let request = URLRequest(url: dailyDataURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }


            let dailyData = try! JSONDecoder().decode(HistoricalDailyData.self, from: data)
            
            
            DispatchQueue.main.async{
                completion(dailyData)
            }
            
        }
        task.resume()
        
    }
    
    func getIntraDay(){
        
    }

}
