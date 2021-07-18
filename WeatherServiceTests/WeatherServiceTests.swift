//
//  WeatherServiceTests.swift
//  WeatherServiceTests
//
//  Created by Debehogne David on 05/07/2021.
//

import XCTest
@testable import americanDream

var fakeResponse = WeatherFakeResponses()


class WeatherServiceTests: XCTestCase {
    
    override func tearDown() {
        TestURLProtocolWeather.loadingHandler = nil
        TestURLProtocolIcon.loadingHandler = nil
    }

    func test_getImageAllShouldBeOkShouldReturnCorrectData() {

        // Given
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.imageData
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
        
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )
        
        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getImage(icone: "example") { data in
            // Then
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func test_getImageErrorShouldReturnNil() {

        // Given
        let response = fakeResponse.responseOK
        let error = fakeResponse.error
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( nil, response,  error)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
        
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )
        
        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getImage(icone: "example") { data in
            //then
            XCTAssertNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getImageResponse500ShouldReturnNil() {

        // Given
        let response = fakeResponse.responseKO
        let jsonData = fakeResponse.imageData
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
        
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )
        
        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getImage(icone: "example") { data in
            // Then
            XCTAssertNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
    
    

 extension WeatherServiceTests {
    
    
    func test_getWeatherAllShouldBeOkReturnGoodCallback() {
        
        //given
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.CorrectData
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
  
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )

        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getWeather(request: client.createWeatherRequest(city: "New+York")) { success, weather in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertNotNil(weather?.imageData)
            XCTAssertEqual("Maubeuge", weather?.city)
            XCTAssertEqual(804, weather?.id)
            XCTAssertEqual(20.15, weather?.temp)
            XCTAssertEqual(weather?.idConditions(id: 804), "Temps nuageux")
            XCTAssertEqual(weather?.idConditions(id: 214), "Violents orages")
            XCTAssertEqual(weather?.idConditions(id: 201), "Pluies avec des orages")
            XCTAssertEqual(weather?.idConditions(id: 210), "Risques d'orages")
            XCTAssertEqual(weather?.idConditions(id: 231), "Orage avec bruine")
            XCTAssertEqual(weather?.idConditions(id: 312), "Temps nuageux avec pluies")
            XCTAssertEqual(weather?.idConditions(id: 503), "Temps ensoleillé avec pluies")
            XCTAssertEqual(weather?.idConditions(id: 511), "Pluies avec risque de neige")
            XCTAssertEqual(weather?.idConditions(id: 521), "Fortes pluies")
            XCTAssertEqual(weather?.idConditions(id: 620), "Risques de neiges")
            XCTAssertEqual(weather?.idConditions(id: 755), "Risques de brouillards")
            XCTAssertEqual(weather?.idConditions(id: 800), "Ciel dégagé")
            // the switch is exhaustive, default value never happends
            XCTAssertEqual(weather?.idConditions(id: 13545), "Conditions inconnues")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherErrorPresentReturnCallbackFalseNil() {

        //given
        let response = fakeResponse.responseOK
        let error = fakeResponse.error
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( nil, response,  error)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
  
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )

        let expectation = XCTestExpectation(description: "Loading")
        
        
        // When
        client.getWeather(request: client.createWeatherRequest(city: "Maubeuge")) { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherIncorrectDataReturnCallbackFalseNil() {

        //given
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.IncorrectData
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
  
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )

        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getWeather(request: client.createIconRequest(icone: "abc")) { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherResponse500SoReturnCallbackFalseNil() {
 
        // Given
        let response = fakeResponse.responseKO
        let jsonData = fakeResponse.CorrectData
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
  
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationWeather) )

        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getWeather(request: client.createWeatherRequest(city: "Tokyo")) { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherAllShouldBeOkButNoIconSoCallbackNil() {
        
        //given
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.CorrectData
       
        TestURLProtocolWeather.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let configurationWeather = URLSessionConfiguration.ephemeral
        configurationWeather.protocolClasses = [TestURLProtocolWeather.self]
  
        //given
        let response2 = fakeResponse.responseOK
        let error2 = fakeResponse.error
        
        TestURLProtocolIcon.loadingHandler = { request in
            return ( nil, response2,  error2)
        }
        
        let configurationIcon = URLSessionConfiguration.ephemeral
        configurationIcon.protocolClasses = [TestURLProtocolIcon.self]
  
        let client = WeatherService(weatherSession: URLSession(configuration: configurationWeather), iconSession: URLSession(configuration: configurationIcon ) )
        
        let expectation = XCTestExpectation(description: "Loading")
        
        // When
        client.getWeather(request: client.createWeatherRequest(city: "New+York")) { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
}




// fake urlProtocol
class TestURLProtocolWeather: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse,  Error?))?
    
    override func startLoading() {
        guard let handler = TestURLProtocolWeather.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (data, response,  error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }
    
    override func stopLoading() {}
}


// fake urlProtocol
class TestURLProtocolIcon: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse,  Error?))?
    
    override func startLoading() {
        guard let handler = TestURLProtocolIcon.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (data, response,  error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }
    
    override func stopLoading() {}
}
