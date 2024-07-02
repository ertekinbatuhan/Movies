//
//  RatingView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.

import SwiftUI

struct RatingView: View {
    
    let rating: Double
    var body: some View {
        let maxRating: Int = 5
        let normalizedRating = Int((rating / 2).rounded(.toNearestOrAwayFromZero))
        
        HStack(spacing: 5) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= normalizedRating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}


#Preview {
    RatingView(rating: 1)
}
