//
//  DollarServiceTests.swift
//  DollarServiceTests
//
//  Created by Debehogne David on 28/06/2021.
//

@testable import americanDream

import XCTest

var fakeResponse = DollarFakeResponseData()

class DollarServiceTests: XCTestCase {
    
    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }
    
    func test_getDollarAllShouldBeOkShouldReturnCorrectCallback() {

        //given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.CorrectData
       
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = DollarService(session: URLSession(configuration: configuration))

        client.getDollar(request: request) { success, dollar in
            print("---------------------")
            XCTAssertTrue(success)
            XCTAssertNotNil(dollar)
            XCTAssertEqual(fakeResponse.rates, dollar!.rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getDollarIncorrectDataShouldFail() {

        //given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.IncorrectData
       
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = DollarService(session: URLSession(configuration: configuration))

        client.getDollar(request: request) { success, dollar in
            print("---------------------")
            XCTAssertFalse(success)
            XCTAssertNil(dollar)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getDollarErrorPresentShouldFail() {

        //given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        let JSONData = fakeResponse.IncorrectData
        let response = fakeResponse.responseOK
        let error = fakeResponse.error
       
        TestURLProtocol.loadingHandler = { request in
            return ( JSONData, response,  error)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = DollarService(session: URLSession(configuration: configuration))

        client.getDollar(request: request) { success, dollar in
            print("---------------------")
            XCTAssertFalse(success)
            XCTAssertNil(dollar)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getDollarWrongResponseShouldFail() {

        //given
        let request = URLRequest(url: URL(string: "https://www.example.com")!)
        let JSONData = fakeResponse.IncorrectData
        let response = fakeResponse.responseKO
       
        TestURLProtocol.loadingHandler = { request in
            return ( JSONData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = DollarService(session: URLSession(configuration: configuration))

        client.getDollar(request: request) { success, dollar in
            print("---------------------")
            XCTAssertFalse(success)
            XCTAssertNil(dollar)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

// fake urlProtocol
final class TestURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse,  Error?))?
    
    override func startLoading() {
        guard let handler = TestURLProtocol.loadingHandler else {
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
