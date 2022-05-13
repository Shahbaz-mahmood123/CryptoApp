//
//  HttpClient.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-05-05.
//

import Foundation

enum HttpMethods: String {
    case POST, GET, PUT, DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

class HttpClient {
    private init() { }
    
    static let shared = HttpClient()
    
    func fetch<T: Codable>(url: URL, apiKey: String?, secretKey:String?) async throws -> [T] {
        var request = URLRequest(url:url)
        
        //TODO, need to make this more generic to account for API calls that are not to Alpaca
        if(apiKey != "" || apiKey != nil ){
            request.addValue(apiKey! , forHTTPHeaderField: "APCA-API-KEY-ID")
        }
        if(secretKey != "" || secretKey != nil){
            request.addValue(apiKey! , forHTTPHeaderField: "APCA-API-KEY-ID")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
    
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
