//
//  CryptoService.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-02-01.
//

import Foundation

class CryptoService: ObservableObject{
    
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

    
    }

