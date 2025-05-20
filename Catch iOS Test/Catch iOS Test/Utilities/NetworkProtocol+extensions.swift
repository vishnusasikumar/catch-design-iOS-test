//
//  NetworkProtocol+extensions.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation

public enum APIError: Error {
    case error_204
    case error_400
    case error_401
    case error_404
    case error_500
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case failedRequest(error: Error)
    case requestTimedOut
    case unknownError
}

public enum NetworkStatus: Int {
    // Undefined error
    case undefined              = 0
    // 2xx Success
    case success                = 200
    case noContent              = 204
    // 4xx Client errors
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case notFound               = 404
    case methodNotAllowed       = 405
    //5xx Server errors
    case internalServerError    = 500
    case notImplemented         = 501
    case badGateway             = 502
    case serviceUnavailable     = 503
}

public protocol CompletionHandler {
    func completionHandler<T:Decodable>(_ data: Data?, _ response: HTTPURLResponse) async throws -> Result<T, APIError>
}

extension CompletionHandler {
    func completionHandler<T:Decodable>(_ data: Data?, _ response: HTTPURLResponse) async throws -> Result<T, APIError> {
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let model = json as? AnyHashable {
                    let decoder = JSONDecoder()
                    do {
                        let data1 = try JSONSerialization.data(withJSONObject: model, options: .prettyPrinted)
                        let value = try decoder.decode(T.self, from: data1)
                        return .success(value)
                    } catch(let error) {
                        throw APIError.failed(error: error)
                    }
                }
            } catch (let error) {
                let statusCode = response.statusCode
                switch NetworkStatus(rawValue: statusCode) {
                case .noContent:
                    // Manage 204 code.
                    throw APIError.error_204
                case .unauthorized:
                    // Manage 401 erorr code.
                    throw APIError.error_401
                case .badRequest:
                    // Manage 400 erorr code.
                    throw APIError.error_400
                case .notFound:
                    // Manage 404 error.
                    throw APIError.error_404
                case .forbidden:
                    throw APIError.failed(error: error)
                default:
                    // Manage unknow erorr code.
                    throw APIError.failed(error: error)
                }
            }
            
        }
        throw APIError.error_204
    }
}
