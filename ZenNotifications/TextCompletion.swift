//
//  TextCompletion.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-26.
//

import Foundation


struct Response: Codable{
    
    var id = String()
    var model = String()
    var choices: [Choice]
}

struct Choice: Codable{
    var finish_reason = String()
    var index = Int()
    var text = String()
}

class GPT3TextComepletion: ObservableObject{
    
    @Published var response = Response.self
    
    func textCompletion(promptText:String, completion:@escaping  (Response) -> ()) {
        
        let token = "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"
        let url = URL(string: "https://api.openai.com/v1/engines/davinci/completions")!

        // prepare json data
        var json: [String: Any] = [
                                    "temperature": 0.7,
                                     "max_tokens": 60,
                                     "top_p": 1.0,
                                     "frequency_penalty": 0,
                                     "presence_penalty": 0]
        json["prompt"] = promptText

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

        //Make POST request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            //assign data to variable to return via completion handler
            let response = try! JSONDecoder().decode(Response.self, from: data)
            //let choice = response.choices
            //print(choice)
            DispatchQueue.main.async {
                completion(response)
            }
        }
        task.resume()
    }
}
