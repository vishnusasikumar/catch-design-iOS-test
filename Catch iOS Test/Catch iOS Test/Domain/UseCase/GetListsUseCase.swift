//
//  GetListsUseCase.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation

protocol GetListsUseCaseProtocol {
    func getRaces() async -> [Item]
}

struct GetListsUseCase: GetListsUseCaseProtocol {
    var repo: ListRepositoryProtocol
    let racesPerPage = 5
    
    init(repo: ListRepositoryProtocol) {
        self.repo = repo
    }
    
    func getRaces() async -> [Item] {
        do {
            return try await repo.getData()
        } catch(let error) {
            debugPrint(error)
            return []
        }
    }
}
