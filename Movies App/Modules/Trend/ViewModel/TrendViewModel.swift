
import Foundation

protocol TrendViewModelProtocol {
    func fetchTrendingMovies(page : Int) async
}

@MainActor
class TrendViewModel: ObservableObject {
    
    @Published var movies: [TrendResult] = []
    @Published var errorMessage: String?
    var currentPage = 1 
    var totalPages = 1

    func fetchTrendingMovies(page: Int = 1) async {
        guard page <= totalPages else { return }

        do {
            let response = try await NetworkService.shared.fetchItems(from: APIConstants.TREND_URL, apiKey: APIConstants.API_KEY, page: page, responseType: Trend.self)
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
}


