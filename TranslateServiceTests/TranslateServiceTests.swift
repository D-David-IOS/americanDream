//
//  TranslateServiceTests.swift
//  TranslateServiceTests
//
//  Created by Debehogne David on 04/07/2021.
//

@testable import americanDream
import XCTest

var fakeResponse = TranslateFakeResponse()

class TranslateServiceTests: XCTestCase {

    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }
    
    func test_getTranslateAllShouldBeOkShouldReturnCorrectCallback() {

        //given
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.CorrectData
       
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = TranslateService(session: URLSession(configuration: configuration))

        client.getTranslate(request: client.createTranslateRequest(sentence: "test1")) { success, translate in
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            XCTAssertEqual(fakeResponse.data, translate!.returnTranslate())
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTranslateIncorrectDataShouldFail() {

        //given
        let response = fakeResponse.responseOK
        let jsonData = fakeResponse.IncorrectData
       
        TestURLProtocol.loadingHandler = { request in
            return ( jsonData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = TranslateService(session: URLSession(configuration: configuration))

        client.getTranslate(request: client.createTranslateRequest(sentence: "une+phrase")) { success, translate in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTranslateErrorPresentShouldFail() {

        //given
        let JSONData = fakeResponse.IncorrectData
        let response = fakeResponse.responseOK
        let error = fakeResponse.error
       
        TestURLProtocol.loadingHandler = { request in
            return ( JSONData, response,  error)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = TranslateService(session: URLSession(configuration: configuration))

        client.getTranslate(request: client.createTranslateRequest(sentence: "une+traduction")) { success, translate in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getTranslateWrongResponseShouldFail() {

        //given
        let JSONData = fakeResponse.IncorrectData
        let response = fakeResponse.responseKO
       
        TestURLProtocol.loadingHandler = { request in
            return ( JSONData, response,  nil)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = TranslateService(session: URLSession(configuration: configuration))

        client.getTranslate(request: client.createTranslateRequest(sentence: "un+autre+test")) { success, translate in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    
    func test_getTranslateNoDataShouldFail() {

        //given
        let response = fakeResponse.responseKO
        let error = fakeResponse.error
       
        TestURLProtocol.loadingHandler = { request in
            return ( nil, response,  error)
        }
        
        let expectation = XCTestExpectation(description: "Loading")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        let client = TranslateService(session: URLSession(configuration: configuration))

        client.getTranslate(request: client.createTranslateRequest(sentence: "un+test")) { success, translate in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
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

