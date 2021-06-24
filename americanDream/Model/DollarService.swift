//
//  DollarService.swift
//  americanDream
//
//  Created by Debehogne David on 24/06/2021.
//

import Foundation

class DollarService {
    static func getDollar(callback : @escaping (Bool, NSDictionary?) -> Void){
    do {
        var request = URLRequest(url: URL(string: "http://data.fixer.io/api/latest?access_key=94566f6059ecbdc8361e202d0cebb6c4")!)
        request.httpMethod = "POST"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response,error ) in
            DispatchQueue.main.async{
                if let data = data , error == nil {
                    print("1516265")
                    if let response = response as? HTTPURLResponse, response.statusCode == 200{
                        print("321")
                        let responseJSON : NSDictionary? = try? JSONSerialization.jsonObject(with: data) as? NSDictionary
                        
                        if let jsonResult = responseJSON {
                            let array = jsonResult["rates"] as! NSDictionary
                            callback(true, array)
                            
                        } else {
                            callback(false,nil)
                        }
                        
                    }  else {
                        callback(false,nil)
                    }
                }  else {
                    callback(false,nil)
                }
            }
        }
        task.resume()
    }
}
}
