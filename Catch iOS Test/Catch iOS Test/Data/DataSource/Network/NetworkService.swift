//
//  NetworkService.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation

public protocol NetworkProtocol {
    func request<T:Decodable>() async throws -> Result<T, APIError>
    func cancelAllTasks()
}

public protocol NetworkServiceProtocol: NetworkProtocol, CompletionHandler { }

class NetworkService: NetworkServiceProtocol {
    private var session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    public func request<T:Decodable>() async throws -> Result<T, APIError> {
        guard let url = Constants.dataURLComponents.url else {
            throw APIError.invalidUrl
        }
        
        return try await makeRequest(url)
    }
    
    private func makeRequest<T:Decodable>(_ url: URL) async throws -> Result<T, APIError> {
        let (data, resp) = try await session.data(from: url)
        guard let response = resp as? HTTPURLResponse else {
            return .failure(APIError.unknownError)
        }
        return try await completionHandler(data, response)
    }
    
    func cancelAllTasks() {
        session.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
    }
}
