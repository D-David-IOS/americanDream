//
//  DollarService.swift
//  americanDream
//
//  Created by Debehogne David on 24/06/2021.
//

import Foundation

protocol HTTPClient {
    func getDollar( callback: @escaping (Bool, Dollar?) -> Void)
}

class DollarService : HTTPClient {
    
    private var session = URLSession(configuration: .default)
    
    public var task : URLSessionDataTask?
    
    func getDollar( callback: @escaping (Bool, Dollar?) -> Void) {
        do {
           let request = createDollarRequest()
            
            task?.cancel()
            task = session.dataTask(with: request) { (data, response, err) in
                DispatchQueue.main.async{
                    guard let data = data else { return callback(false,nil) }
                    
                    do {
                        let dollar = try JSONDecoder().decode(Dollar.self, from: data)
                        callback(true, dollar)
                    } catch let jsonErr {
                        print("Erreur de décodage", jsonErr)
                    }
                    
                }
            }
            task?.resume()
        }
        
    }
    
    
    public func createDollarRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "http://data.fixer.io/api/latest?access_key=94566f6059ecbdc8361e202d0cebb6c4")!)
        request.httpMethod = "POST"
        return request
    }
    
}
