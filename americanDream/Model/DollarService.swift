//
//  DollarService.swift
//  americanDream
//
//  Created by Debehogne David on 24/06/2021.
//

import Foundation

class DollarService {
    
    // injection dependency for UnitTests
    let session : URLSession
    
    init(session : URLSession){
        self.session = session
    }
    
    // This function return a callback to the contoller with 2 parameters
    // Bool : will be true if succes, false if an error is present or incorrect data
    // Dollar : contains the dictionnary of all current money, nil if error
    func getDollar(callback: @escaping (Bool, Dollar?) -> Void) {
        do {
            let request = createDollarRequest()
            var task : URLSessionDataTask?
            
            task?.cancel()
            task = session.dataTask(with: request) { (data, response, err) in
                DispatchQueue.main.async{
                    // if no data or an error is present return callback(false,nil)
                    guard let data = data, err == nil else { return callback(false,nil) }
                     
                    // if the statuscode if 200 all is ok, else return callback(false,nil)
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return callback(false,nil)}
                    
                    do {
                        // here we have data, so we try to decode into a dollar
                        let dollar = try JSONDecoder().decode(Dollar.self, from: data)
                        callback(true, dollar)
                    } catch let jsonErr {
                        // if decode failed, return an error and callback(false,nil)
                        print("Erreur de décodage", jsonErr)
                        return callback(false,nil)
                    }
                    
                }
            }
            task?.resume()
        }
        
    }
    
    // create a request for the api "fixer"
    public func createDollarRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "http://data.fixer.io/api/latest?access_key=94566f6059ecbdc8361e202d0cebb6c4")!)
        request.httpMethod = "POST"
        return request
    }
    
}
