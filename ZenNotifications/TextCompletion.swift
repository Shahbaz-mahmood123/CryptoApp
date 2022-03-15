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
    
    var gpt3Key: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Info.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "GPT3APIKey") as? String else {
                fatalError("Couldn't find key 'GPT3APIKey' in 'Info.plist'.")
            }
            return value
        }
    }
    
    
    func textCompletion(promptText:String, completion:@escaping  (Response) -> ()) {
        
        //let token = "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"
        let url = URL(string: "https://api.openai.com/v1/engines/davinci/completions")!
        
        // prepare json data
        var json: [String: Any] = [
            "temperature": 0,
            "max_tokens": 100,
            "top_p": 1,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0,
            "stop": ["\n"]
        ]
        json["prompt"] = promptText
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(gpt3Key)", forHTTPHeaderField: "Authorization")
        
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
