//
//  ListRepository.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation
import SwiftUICore

protocol ListRepositoryProtocol {
    func getData() async throws -> [Item]
}

struct ListRepository: ListRepositoryProtocol {
    private let service : NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func  getData() async throws -> [Item] {
        do {
            let result: Result<[Item], APIError> = try await service.request()
            switch result {
            case .success(let items):
                return items
            case .failure(let error):
                throw APIError.failed(error: error)
            }
        } catch(let error) {
            throw APIError.failed(error: error)
        }
    }
}
