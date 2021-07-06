//
//  WeatherFakeResponses.swift
//  WeatherServiceTests
//
//  Created by Debehogne David on 05/07/2021.
//

import Foundation

class WeatherFakeResponses {
    let responseOK = HTTPURLResponse(url: URL(string: "www.google.fr")!,statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKO = HTTPURLResponse(url: URL(string: "www.google.fr")!,statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class WeatherError : Error {}
    let error = WeatherError()
    
    var CorrectData : Data {
        let bundle = Bundle(for: WeatherFakeResponses.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let IncorrectData = "nimportequoi".data(using: .utf8)!

    let imageData = "image with a long description .........".data(using: .utf8)
}
