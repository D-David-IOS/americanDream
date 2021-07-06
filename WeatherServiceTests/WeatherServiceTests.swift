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
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
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
        client.getWeather(request: request) { success, weather in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertNotNil(weather?.imageData)
            XCTAssertEqual("Maubeuge", weather?.city)
            XCTAssertEqual(804, weather?.id)
            XCTAssertEqual(20.15, weather?.temp)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherErrorPresentReturnCallbackFalseNil() {

        //given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
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
        client.getWeather(request: request) { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherIncorrectDataReturnCallbackFalseNil() {

        //given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
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
        client.getWeather(request: request) { success, weather in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getWeatherResponse500SoReturnCallbackFalseNil() {
 
        // Given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
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
        client.getWeather(request: request) { success, weather in
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
