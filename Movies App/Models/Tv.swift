//
//  Tv.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import Foundation

struct Tv: Codable {
    let page: Int
    let results: [TvResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TvResult: Codable , Identifiable{
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id : Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let firstAirDate, name: String
    let posterPath : String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

