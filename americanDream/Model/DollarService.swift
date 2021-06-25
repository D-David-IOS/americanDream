//
//  DollarService.swift
//  americanDream
//
//  Created by Debehogne David on 24/06/2021.
//

import Foundation

class DollarService {
    static func getDollar(callback : @escaping (Bool, Dollar?) -> Void){
        do {
            var request = URLRequest(url: URL(string: "http://data.fixer.io/api/latest?access_key=94566f6059ecbdc8361e202d0cebb6c4")!)
            request.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                DispatchQueue.main.async{
                    guard let data = data else { return }
                    
                    do {
                        let dollar = try JSONDecoder().decode(Dollar.self, from: data)
                        callback(true, dollar)
                    } catch let jsonErr {
                        print("Erreur de décodage", jsonErr)
                    }
                    
                }
            }
            .resume()
        }
    }
}
