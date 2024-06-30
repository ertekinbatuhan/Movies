
//  Created by Batuhan Berk Ertekin on 30.06.2024.

import Foundation

@MainActor
class TvViewModel: ObservableObject {
    
    @Published var tvShows: [TvResult] = []
    @Published var errorMessage: String?
    var currentPage = 1
    var totalPages = 1

    func fetchTvShows(page: Int = 1) async {
        guard page <= totalPages else { return }

        do {
            let response = try await fetchItems(from: APIConstants.TV_URL, apiKey: APIConstants.API_KEY, page: page, responseType: Tv.self)
            if page == 1 {
                self.tvShows = response.results
            } else {
                self.tvShows += response.results
            }
            self.totalPages = response.totalPages
            self.currentPage = page 
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching TV shows: \(error.localizedDescription)")
        }
    }
    
    private func fetchItems<T: Codable>(from url: String, apiKey: String, page: Int, responseType: T.Type) async throws -> T {
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

