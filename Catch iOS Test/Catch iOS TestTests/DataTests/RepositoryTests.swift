//
//  RepositoryTests.swift
//  Catch iOS TestTests
//
//  Created by Admin on 20/05/2025.
//

import Testing
@testable import Catch_iOS_Test
import Foundation

class MockNetworkService: NetworkServiceProtocol {
    
    var result: Data?
    var error: APIError?
    var responseCode: Int
    
    init(result: Data? = nil, error: APIError? = nil, responseCode: Int = 200) {
        self.result = result
        self.error = error
        self.responseCode = responseCode
    }

    func request<T:Decodable>() async throws -> Result<T, APIError> {
        if let result {
            guard let response = HTTPURLResponse(url: Constants.urlComponents.url!, statusCode: responseCode, httpVersion: nil, headerFields: nil) else {
                throw APIError.error_500
            }
            return try await completionHandler(result, response)
        } else {
            if let error {
                throw error
            } else {
                throw APIError.error_500
            }
        }
    }
    
    func cancelAllTasks() {
        // Empty conformance of protocol
    }
}

@Suite("Repository protocol tests") struct RepositoryTests: FetchMockJson {
    
    var mockNetworService: NetworkServiceProtocol!
    var repository: ListRepository!
    
    init() async throws {
        mockNetworService = MockNetworkService()
        repository = ListRepository(service: mockNetworService)
    }

    @Test("Repository successfully fetches data") mutating func repositoryFetchSuccess() async throws {
        let data = try #require(try loadMockResponse(with: "CatchMockResponse"), "Result mocks need to be fetched")
        mockNetworService = MockNetworkService(result: data)
        repository = ListRepository(service: mockNetworService)
        let itemsArray = try #require(await repository.getData(), "Repository should return a value")
        #expect(itemsArray.count >= 0)
    }
    
    @Test("Repository failed to fetch data") mutating func repositoryFetchFailure() async throws {
        mockNetworService = MockNetworkService(result: nil, error: APIError.error_204, responseCode: 204)
        repository = ListRepository(service: mockNetworService)
        await #expect(throws: APIError.self) {
            try await repository.getData()
        }
    }
    
    
} 
