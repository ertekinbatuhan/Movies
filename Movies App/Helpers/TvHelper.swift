import Foundation

class TvHelper {
    
    static func filteredTvShows(tvShows: [TvResult], searchText: String) -> [TvResult] {
        if searchText.isEmpty {
            return tvShows
        } else {
            return tvShows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
}

