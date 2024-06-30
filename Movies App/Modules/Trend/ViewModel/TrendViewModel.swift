
import Foundation

@MainActor
class TrendViewModel: ObservableObject {
    
    @Published var movies: [TrendResult] = []
    @Published var errorMessage: String?
    var currentPage = 1 
    var totalPages = 1

    func fetchTrendingMovies(page: Int = 1) async {
        guard page <= totalPages else { return }

        do {
            let response = try await fetchItems(from: APIConstants.MOVIE_URL, apiKey: APIConstants.API_KEY, page: page, responseType: Trend.self)
            if page == 1 {
                self.movies = response.results
            } else {
                self.movies += response.results
            }
            self.totalPages = response.totalPages
            self.currentPage = page
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching movies: \(error.localizedDescription)")
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


