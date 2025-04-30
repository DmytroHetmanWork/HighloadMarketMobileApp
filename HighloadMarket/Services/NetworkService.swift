//
//  NetworkService.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//


import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func sendRequest<T: Decodable>(
        _ endpoint: APIEndpoint,
        responseModel: T.Type,
        decoder: JSONDecoder = .defaultDecoder
    ) async throws -> T {
        let request = endpoint.request

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try decoder.decode(T.self, from: data)
    }
}

