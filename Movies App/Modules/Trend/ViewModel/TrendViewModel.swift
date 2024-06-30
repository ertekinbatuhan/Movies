
import Foundation

@MainActor
class TrendViewModel: ObservableObject {
    
    @Published var movies: [TrendResult] = []
    @Published var errorMessage: String?

    func fetchTrendingMovies() async {
        do {
            self.movies = try await fetchItems(from: APIConstants.MOVIE_URL, apiKey: APIConstants.API_KEY, responseType: Trend.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching movies: \(error.localizedDescription)")
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
