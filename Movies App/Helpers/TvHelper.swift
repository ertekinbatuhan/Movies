//
//  TvHelper.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

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

