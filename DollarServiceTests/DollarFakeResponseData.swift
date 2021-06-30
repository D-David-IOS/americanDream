//
//  DollarFakeResponseData.swift
//  DollarServiceTests
//
//  Created by Debehogne David on 28/06/2021.
//

import Foundation

class DollarFakeResponseData {
    let responseOK = HTTPURLResponse(url: URL(string: "www.google.fr")!,statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKO = HTTPURLResponse(url: URL(string: "www.google.fr")!,statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class DollarError : Error {}
    let error = DollarError()
    
    var DollarCorrectData : Data {
        let bundle = Bundle(for: DollarFakeResponseData.self)
        let url = bundle.url(forResource: "Dollar", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let DollarIncorrectData = "nimportequoi".data(using: .utf8)!
    
    
}
