//
//  Tickets.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import Foundation
import SwiftUI


struct Ticket: Codable, Identifiable {
    let id = UUID()
    var requester: String
    var title: String
    var body: String
}


class Api : ObservableObject{
    @Published var tickets = [Ticket]()
    
    func loadData(completion:@escaping ([Ticket]) -> ()) {
        guard let url = URL(string: "https://mocki.io/v1/df55f960-c899-4089-b3dd-1e3a663ed361") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let tickets = try! JSONDecoder().decode([Ticket].self, from: data!)
           // print(tickets)
            DispatchQueue.main.async {
                completion(tickets)
            }
        }.resume()
        
    }


    
}
