//
//  Dollar.swift
//  americanDream
//
//  Created by Debehogne David on 23/06/2021.
//

import Foundation

class DollarService {
    private static let weatherUrl = URL(string: "http://data.fixer.io/api/")!
    
    static func getDollar() {
        
        
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        
        let body = "latest?access_key=0fe06c8097219c76906db00d6d2a8bde"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response,error ) in
            if let data = data , error == nil {
                print("1516265")
                if let response = response as? HTTPURLResponse, response.statusCode == 200{
                    print("321")
                    if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                       
                        let text = responseJSON["base"]{
                        print("kjbb")
                        print(text)
                    }
                    
                }
            }
        }
        task.resume()
    }
}
