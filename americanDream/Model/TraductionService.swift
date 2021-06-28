//
//  TraductionService.swift
//  americanDream
//
//  Created by Debehogne David on 26/06/2021.
//

import Foundation

class TraductionService {
    
    static func getTranslate(sentence : String, callback : @escaping (Bool, Traduction?) -> Void){
        do {
            print("123")
            var request = URLRequest(url: URL(string : "https://translation.googleapis.com/language/translate/v2?key=AIzaSyB3NVU3O1EMszpcwD43pb0Mo0MIU7TSMj0&q="+"\(sentence)"+"&target=en")!)
            request.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                DispatchQueue.main.async{
                    guard let data = data else { return }
                    
                    print(data)
                    do {
                        let traduction = try JSONDecoder().decode(Traduction.self, from: data)
                        callback(true, traduction)
                    } catch let jsonErr {
                        print("Erreur de décodage", jsonErr)
                    }
                    
                }
            }
            .resume()
        }
    }
}
