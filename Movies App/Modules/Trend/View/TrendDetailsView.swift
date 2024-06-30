//
//  TrendDetailsView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct TrendDetailsView: View {
    
    let movie: TrendResult
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { result in
                    switch result {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 350)
                            .cornerRadius(15)
                    default:
                        ProgressView()
                            .frame(width: 150, height: 250)
                    }
                }
                .cornerRadius(15)
                .shadow(radius: 4)
                
               
                Text(movie.title ?? "")
                    .font(.title)
                    .foregroundColor(.primary)
                
                
                HStack {
                    RatingView(rating: movie.voteAverage)
                    Spacer()
                    Text(movie.releaseDate ?? "")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Popularity: \(Int(movie.popularity))")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    Spacer()
                    }
                               
               
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Text(movie.title?.prefix(20) ?? ""), displayMode: .inline)
    }
}

#Preview {
    TrendDetailsView(movie: TrendResult(
        backdropPath: "/example.jpg",
        id: 1,
        title: "Example Movie",
        originalTitle: "Example Original Title",
        overview: "This is a sample overview of the movie.",
        posterPath: "/example_poster.jpg",
        mediaType: .movie,
        adult: false,
        originalLanguage: .en,
        genreIDS: [1, 2, 3],
        popularity: 100.0,
        releaseDate: "2023-01-01",
        video: false,
        voteAverage: 8.5,
        voteCount: 1200,
        name: nil,
        originalName: nil,
        firstAirDate: nil,
        originCountry: nil
    ))
}
