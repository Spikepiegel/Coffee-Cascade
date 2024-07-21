//
//  DataRepository.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation

protocol IDataRepository {
    func fetchData(from path: String, method: HTTPMethod) async throws -> Data
}

final class DataRepository: IDataRepository {
    private let baseURL = AppConstants.baseURL
    private let headers: [String: String] = {
        var headerDict: [String: String] = [:]
        if let apiKey = AppConstants.apiKey {
            headerDict["x-rapidapi-key"] = apiKey
        }
        headerDict["x-rapidapi-host"] = AppConstants.host
        return headerDict
    }()

    func fetchData(from path: String, method: HTTPMethod) async throws -> Data {
        let urlString = baseURL + path
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
