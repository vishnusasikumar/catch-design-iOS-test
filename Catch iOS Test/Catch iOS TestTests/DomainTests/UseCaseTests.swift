//
//  UseCaseTests.swift
//  Catch iOS TestTests
//
//  Created by Admin on 20/05/2025.
//

import Testing
@testable import Catch_iOS_Test
import Foundation

struct MockListRepository: ListRepositoryProtocol {
    var items: [Item]?
    var error: APIError?
    
    init(items: [Item]? = nil, error: APIError? = nil) {
        self.items = items
        self.error = error
    }
    
    
    func getData() async throws -> [Item] {
        if let items {
            return items
        } else {
            if let error {
                throw APIError.failed(error: error)
            }
        }
        throw APIError.unknownError
    }
}

@Suite("UseCase protocol tests") struct UseCaseTests: FetchMockJson {
    
    var repository: ListRepositoryProtocol
    var useCase: GetListsUseCase
    
    init() async throws {
        repository = MockListRepository()
        useCase = GetListsUseCase(repo: repository)
    }

    @Test("Repository successfully fetches data") mutating func repositoryFetchSuccess() async throws {
        let result: [Item] = try #require(try decodeJson(from: "CatchMockResponse"))
        repository = MockListRepository(items: result)
        useCase = GetListsUseCase(repo: repository)
        let items = try #require(await useCase.getListItems(), "UseCase should return values")
        #expect(items.count >= 0)
    }
    
    @Test("Repository failed to fetch data") mutating func repositoryFetchFailure() async throws {
        repository = MockListRepository(items: nil, error: APIError.errorDecode)
        await #expect(throws: APIError.self) {
            try await repository.getData()
        }
    }

}
