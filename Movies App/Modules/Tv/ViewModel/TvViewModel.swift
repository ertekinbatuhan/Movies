
//  Created by Batuhan Berk Ertekin on 30.06.2024.

import Foundation

protocol TvViewModelProtocol {
    func fetchTvShows(page : Int) async
}

@MainActor
class TvViewModel: ObservableObject {
    
    @Published var tvShows: [TvResult] = []
    @Published var errorMessage: String?
    var currentPage = 1
    var totalPages = 1

    func fetchTvShows(page: Int = 1) async {
            guard page <= totalPages else { return }

            do {
                let response = try await NetworkService.shared.fetchItems(from: APIConstants.TV_URL, apiKey: APIConstants.API_KEY, page: page, responseType: Tv.self)
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
    
}

