
import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    
    @Published var movies: [TrendResult] = []
    @Published var tvShows: [TvResult] = []
    @Published var popular: [PopularResult] = []
    @Published var errorMessage: String?

    func fetchTrendingMovies() async {
        do {
            self.movies = try await fetchItems(from: APIConstants.MOVIE_URL, apiKey: APIConstants.API_KEY, responseType: Trend.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching movies: \(error.localizedDescription)")
        }
    }
    
    func fetchPopularMovies() async {
        do {
            self.popular = try await fetchItems(from: APIConstants.POPULAR_URL, apiKey: APIConstants.API_KEY, responseType: Popular.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching popular movies: \(error.localizedDescription)")
        }
    }

    func fetchTvShows() async {
        do {
            self.tvShows = try await fetchItems(from: APIConstants.TV_URL, apiKey: APIConstants.API_KEY, responseType: Tv.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching TV shows: \(error.localizedDescription)")
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
