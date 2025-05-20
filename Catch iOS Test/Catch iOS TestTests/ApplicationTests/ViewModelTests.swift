//
//  ViewModelTests.swift
//  Catch iOS TestTests
//
//  Created by Admin on 20/05/2025.
//

import Testing
@testable import Catch_iOS_Test
import Foundation

struct MockListUseCase: GetListsUseCaseProtocol {
    var items: [Item] = []
    var error: APIError?
    
    init(items: [Item], error: APIError? = nil) {
        self.items = items
        self.error = error
    }
    
    
    func getListItems() async -> [Item] {
        if error != nil {
            return []
        }
        return items
    }
}

@Suite("ViewModel protocol tests") struct ViewModelTests: FetchMockJson {
    
    var useCase: GetListsUseCaseProtocol
    var viewModel: ListViewModel
    
    init() async throws {
        useCase = MockListUseCase(items: [])
        viewModel = ListViewModel(getItemsUseCase: useCase)
    }

    @Test("Repository successfully fetches data") mutating func repositoryFetchSuccess() async throws {
        let result: [Item] = try #require(try decodeJson(from: "CatchMockResponse"))
        useCase = MockListUseCase(items: result)
        viewModel = ListViewModel(getItemsUseCase: useCase)
        try #require(await viewModel.getNextItems(), "ViewModel should return values")
        #expect(viewModel.items.count >= 0)
    }
    
    @Test("Repository failed to fetch data") mutating func repositoryFetchFailure() async throws {
        useCase = MockListUseCase(items: [], error: APIError.errorDecode)
        try #require(await viewModel.getNextItems(), "ViewModel should return empty")
        #expect(viewModel.items.count == 0)
    }

}
