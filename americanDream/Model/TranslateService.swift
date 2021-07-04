//
//  TraductionService.swift
//  americanDream
//
//  Created by Debehogne David on 26/06/2021.
//

import Foundation

class TranslateService {
    
    // injection dependency for UnitTests
    let session : URLSession
    
    init(session : URLSession){
        self.session = session
    }
    
    // This function return a callback to the contoller with 2 parameters
    // Bool : will be true if succes, false if an error is present or incorrect data
    // Traduction : contains the dictionnary with the traduction, nil if error
    func getTranslate(request : URLRequest, callback : @escaping (Bool, Translate?) -> Void){
        do {
            var task : URLSessionDataTask?
            
            task?.cancel()
            task = session.dataTask(with: request) { (data, response, err) in
                DispatchQueue.main.async{
                    // if no data or an error is present return callback(false,nil)
                    guard let data = data else { return callback(false,nil) }
                    // if the statuscode if 200 all is ok, else return callback(false,nil)
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return callback(false,nil)}
                    
                    do {
                        // here we have data, so we try to decode into a translation
                        let translation = try JSONDecoder().decode(Translate.self, from: data)
                        callback(true, translation)
                    } catch let jsonErr {
                        // if decode failed, return an error and callback(false,nil)
                        print("Erreur de décodage", jsonErr)
                        callback(false,nil)
                    }
                    
                }
            }
            task?.resume()
        }
    }
    
    // create a request for the api "googleTranslate"
    public func createDollarRequest(sentence : String) -> URLRequest {
        var request = URLRequest(url: URL(string : "https://translation.googleapis.com/language/translate/v2?key=AIzaSyB3NVU3O1EMszpcwD43pb0Mo0MIU7TSMj0&q="+"\(sentence)"+"&target=en&format=text")!)
        request.httpMethod = "POST"
        return request
    }
    
}
