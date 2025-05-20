//
//  TestUtils.swift
//  Catch iOS TestTests
//
//  Created by Admin on 20/05/2025.
//

import Testing
import Foundation

protocol FetchMockJson {
    func loadMockResponse(with fileName: String) throws -> Data?
    func decodeJson<T: Decodable>(from fileName: String) throws -> T?
}

extension FetchMockJson {
    func loadMockResponse(with fileName: String) throws -> Data? {
        let url = try #require(Bundle.main.url(forResource: fileName, withExtension: "json"), "JSON file should be found")
        let data = try #require(try Data(contentsOf: url), "Data should be obtained from the filepath")
        return data
    }

    func decodeJson<T: Decodable>(from fileName: String) throws -> T? {
        let data = try #require(try loadMockResponse(with: fileName))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let jsonData: T = try #require(try decoder.decode(T.self, from: data), "JSON Decoding failed")
        return jsonData
    }
}
