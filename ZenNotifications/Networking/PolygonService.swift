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
func getDailyOpenClose(completion: @escaping(DailyOpenClose) -> Void){
        let dailyDataURL = URL(string:"https://api.polygon.io/v1/open-close/crypto/BTC/USD/2022-03-13?adjusted=true&apiKey=\(polygonKey)")!
        
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
    
}
