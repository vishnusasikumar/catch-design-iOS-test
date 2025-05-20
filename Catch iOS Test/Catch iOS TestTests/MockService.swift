//
//  MockService.swift
//  Catch iOS TestTests
//
//  Created by Admin on 20/05/2025.
//

import Foundation

class MockService: NetworkServiceProtocol {
    private let responseCode: Int
    private let shouldError: Bool
    
    init(responseCode: Int = 200, shouldError: Bool = false) {
        self.responseCode = responseCode
        self.shouldError = shouldError
    }
    
    // Hardcoded to return just the racing data for now
    func request<T:Decodable>() async throws -> Result<T, APIError> {
        let response = HTTPURLResponse(url: Constants.urlComponents.url!, statusCode: responseCode, httpVersion: nil, headerFields: nil)
        let url = Bundle.main.url(forResource: "CatchMockResponse", withExtension: "json")!
        var data: Data? = nil
        if !shouldError {
            data = try Data(contentsOf: url)
        }
        
        return try await completionHandler(data, response!)
    }
    
    func cancelAllTasks() {
        // Empty conformance of protocol
    }
}
