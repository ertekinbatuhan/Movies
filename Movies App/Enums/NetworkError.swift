//
//  NetworkError.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed with error: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode response with error: \(error.localizedDescription)"
        }
    }
}
