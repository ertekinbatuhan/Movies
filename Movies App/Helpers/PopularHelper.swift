//
//  PopularHelper.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import Foundation

class PopularHelper {
    
    static func filteredPopularResults(results: [PopularResult], searchText: String) -> [PopularResult] {
        if searchText.isEmpty {
            return results
        } else {
            return results.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
}
