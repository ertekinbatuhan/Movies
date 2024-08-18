//
//  NetworkService.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 18.08.2024.
//

import Foundation

 class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchItems<T: Codable>(from url: String, apiKey: String, page: Int, responseType: T.Type) async throws -> T {
        guard let url = URL(string: "\(url)?api_key=\(apiKey)&page=\(page)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
