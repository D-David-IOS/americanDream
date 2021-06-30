//
//  DollarURLSessionFake.swift
//  DollarServiceTests
//
//  Created by Debehogne David on 29/06/2021.
//

@testable import americanDream

import Foundation

class MockHTTPClient : HTTPClient{
    
    func getDollar(request: URLRequest, callback: @escaping (Bool, Dollar?) -> Void) {
       
        guard let url = Bundle(for: MockHTTPClient.self).url(forResource: "Dollar", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return callback(false,nil)
        }
            
        let dollar = try? JSONDecoder().decode(Dollar.self, from: data)
        callback(true, dollar)
    }
}
