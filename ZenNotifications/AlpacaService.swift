//
//  AlpacaService.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-05.
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

// MARK: - Image
struct NewsImage: Codable {
    let size: Size
    let url: String

    enum CodingKeys: String, CodingKey {
        case size = "size"
        case url = "url"
    }
}

enum Size: String, Codable {
    case large = "large"
    case small = "small"
    case thumb = "thumb"
}


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
    
    @Published var newsResponse = NewsResponse.self
    
    func getnews(completion: @escaping (NewsResponse) -> () ){
        
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
            //let choice = response.choices
            print(newsResponse)
            DispatchQueue.main.async {
                completion(newsResponse)
            }
        }
        task.resume()
        
        
    }
    

}
