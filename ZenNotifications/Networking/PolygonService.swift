//
//  PolygonService.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-12.
//

import Foundation
enum error: Error{
    case BadURL
    case NoData
    case DecodingError
}

class PolygonService: ObservableObject{
    
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
    
    //TODO: get current Date interpolate into below URL
    func getDailyOpenClose(date: String ,completion: @escaping(DailyOpenClose) -> Void){
        let dailyDataURL = URL(string:"https://api.polygon.io/v1/open-close/crypto/BTC/USD/\(date)?adjusted=true&apiKey=\(polygonKey)")!
        
        let request = URLRequest(url: dailyDataURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            
            let dailyOpenClose = try! JSONDecoder().decode(DailyOpenClose.self, from: data)
            print(dailyOpenClose)
            
            DispatchQueue.main.async{
                completion(dailyOpenClose)
            }
            
        }
        task.resume()
    }
    
    func getAvailableExchanges(){
        
    }
    func getCryptoData(completion:@escaping (CryptoResponse) -> ()){
        
        
        
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
            
            let cryptoData = try! JSONDecoder().decode(CryptoResponse.self, from: data)
            print(cryptoData)
            
            DispatchQueue.main.async{
                completion(cryptoData)
            }
            
        }
        task.resume()
    }
    
    
    
    func  getCurrentMarketStatus(completion: @escaping(CurrentMarketStatus) -> ()){
        let dailyDataURL = URL(string:"https://api.polygon.io/v1/marketstatus/now?apiKey=\(polygonKey)")!
        
        let request = URLRequest(url: dailyDataURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            
            let marketStatus = try! JSONDecoder().decode(CurrentMarketStatus.self, from: data)
            print(marketStatus)
            
            DispatchQueue.main.async{
                completion(marketStatus)
            }
            
        }
        task.resume()
        
    }
    
}
