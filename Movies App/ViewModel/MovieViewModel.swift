//
//  MovieViewModel.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    
    let MOVIE_URL = "https://api.themoviedb.org/3/trending/all/day"
    let TV_URL = "https://api.themoviedb.org/3/discover/tv"
    let API_KEY = "87a0e030e371512f86e7ac232282e32c"
    let POPULAR_URL = "https://api.themoviedb.org/3/movie/popular"
    
    @Published var movies: [TrendResult] = []
    @Published var tvShows: [TvResult] = []
    @Published var popular : [PopularResult] = []
  
    
    @Published var errorMessage: String?

    func fetchTrendingMovies() async {
        do {
            self.movies = try await fetchItems(from: MOVIE_URL, apiKey: API_KEY, responseType: Trend.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching movies: \(error.localizedDescription)")
        }
    }
    
    func fetchPopularMovies() async {
        do {
            self.popular = try await fetchItems(from: POPULAR_URL, apiKey: API_KEY, responseType: Popular.self).results
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching popular movies: \(error.localizedDescription)")
        }
    }


    func fetchTvShows() async {
        do {
            self.tvShows = try await fetchItems(from: TV_URL, apiKey: API_KEY, responseType: Tv.self).results
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

