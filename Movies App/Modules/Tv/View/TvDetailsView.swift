//
//  TvViewDetails.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct TvDetailsView: View {
    
    let tvShow: TvResult
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")")) { result in
                    switch result {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                            .cornerRadius(15)
                    default:
                        ProgressView()
                            .frame(width: 150, height: 250)
                    }
                }
                .cornerRadius(15)
                .shadow(radius: 4)
                
               
                Text(tvShow.name)
                    .font(.title)
                    .foregroundColor(.primary)
                
                
                HStack {
                    RatingView(rating: tvShow.voteAverage)
                    Spacer()
                    Text(tvShow.firstAirDate)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Popularity: \(Int(tvShow.popularity))")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    Spacer()
                    }
                               
               
                Text(tvShow.overview)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Text(tvShow.name.prefix(20)), displayMode: .inline)
    }
}

#Preview {
    TvDetailsView(tvShow: TvResult(adult: false, backdropPath: "test",  genreIDS: [1,2,3] , id: 51500 , originCountry: ["test"], originalLanguage: "test", originalName: "test", overview: "test", popularity: 5.0, firstAirDate: "test", name: "test", posterPath: "test", voteAverage: 5.0, voteCount: 5))
}

