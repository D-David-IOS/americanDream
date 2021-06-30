//
//  DollarServiceTests.swift
//  DollarServiceTests
//
//  Created by Debehogne David on 28/06/2021.
//

@testable import americanDream

import XCTest

class DollarServiceTests: XCTestCase {
    
    func testGetDollarShouldGoodCallbackAndGoodDollar(){
        let fakeCall = MockHTTPClient()
        
        fakeCall.getDollar() { bool, dollar in
            print("**********")
            XCTAssertTrue(bool)
            XCTAssertNotNil(dollar)
        }

    }
    
}
