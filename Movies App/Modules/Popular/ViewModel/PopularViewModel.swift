import SwiftUI

protocol PopularViewModelProtocol {
    func fetchPopularMovies(page : Int) async
}

@MainActor
class PopularViewModel: ObservableObject {
    
    @Published var popular: [PopularResult] = []
    @Published var errorMessage: String?
     var currentPage = 1
     var totalPages = 1

    func fetchPopularMovies(page: Int = 1) async {
        guard page <= totalPages else { return }

        do {
            let response = try await NetworkService.shared.fetchItems(from: APIConstants.POPULAR_URL, apiKey: APIConstants.API_KEY, page: page, responseType: Popular.self)
            if page == 1 {
                self.popular = response.results
            } else {
                self.popular += response.results
            }
            self.totalPages = response.totalPages
            self.currentPage = page
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching popular movies: \(error.localizedDescription)")
        }
    }
    
}
