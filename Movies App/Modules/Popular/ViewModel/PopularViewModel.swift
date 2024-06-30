//
//  PopularViewModel.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import Foundation

@MainActor
class PopularViewModel  : ObservableObject {
    
    @Published var popular: [PopularResult] = []
    @Published var errorMessage: String?
    
    
    
    func fetchPopularMovies() async {
        do {
            self.popular = try await fetchItems(from: APIConstants.POPULAR_URL, apiKey: APIConstants.API_KEY, responseType: Popular.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching popular movies: \(error.localizedDescription)")
        }
    }
    
    
    private func fetchItems<T: Codable>(from url: String, apiKey: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: "\(url)?api_key=\(apiKey)") else {
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
