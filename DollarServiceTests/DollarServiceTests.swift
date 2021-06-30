//
//  DollarServiceTests.swift
//  DollarServiceTests
//
//  Created by Debehogne David on 28/06/2021.
//

@testable import americanDream

import XCTest

var fakeDollar = DollarFakeResponseData()

class DollarServiceTests: XCTestCase {
    
    func testGetDollarShouldGoodCallbackAndGoodDollar(){
        print("123")
        let sut = MockHTTPClient()
        let request = URLRequest(url: URL(string: "www.google.com")!)
        
        sut.getDollar(request: request ) { bool, dollar in
            print("**********")
            XCTAssertTrue(bool)
            XCTAssertNotNil(dollar)
        }

    }
      
    func testGetDollarShouldError(){
        print("123")
        let sut = MockHTTPClient()
        let request = URLRequest(url: URL(string: "www.google.com")!)
        
        sut.getDollar(request: request ) { bool, dollar in
            print("**********")
            XCTAssertFalse(bool)
            XCTAssertNil(dollar)
        }

    }
 
}
