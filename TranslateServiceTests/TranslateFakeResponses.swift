//
//  TraductionFakeResponseData.swift
//  TraductionServiceTests
//
//  Created by Debehogne David on 04/07/2021.
//

import Foundation

class TranslateFakeResponse {
    let responseOK = HTTPURLResponse(url: URL(string: "www.google.fr")!,statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKO = HTTPURLResponse(url: URL(string: "www.google.fr")!,statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class TranslateError : Error {}
    let error = TranslateError()
    
    var CorrectData : Data {
        let bundle = Bundle(for: TranslateFakeResponse.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let IncorrectData = "nimportequoi".data(using: .utf8)!
    
    let data = "I am translated"
    
}
