//
//  GetListsUseCase.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation

protocol GetListsUseCaseProtocol {
    func getListItems() async -> [Item]
}

struct GetListsUseCase: GetListsUseCaseProtocol {
    var repo: ListRepositoryProtocol
    
    init(repo: ListRepositoryProtocol) {
        self.repo = repo
    }
    
    func getListItems() async -> [Item] {
        do {
            return try await repo.getData()
        } catch(let error) {
            debugPrint(error)
            return []
        }
    }
}
