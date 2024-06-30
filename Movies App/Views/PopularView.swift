//
//  PopularView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

import SwiftUI

struct PopularView: View {
    @ObservedObject var viewModel = MovieViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.popular) { movie in
                        VStack {
                            ZStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { popular in
                                    switch popular {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 250)
                                            .cornerRadius(15)
                                    default:
                                        ProgressView()
                                            .frame(width: 150, height: 250)
                                    }
                                }
                                .cornerRadius(15)
                                .shadow(radius: 4)
                                
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(movie.title)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .lineLimit(2)
                                                .padding(.horizontal, 10)
                                            
                                            Text("Rating: \(movie.voteAverage)")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 10)
                                            
                                            Text("Release Date: \(movie.releaseDate)")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 10)
                                        }
                                        .padding(.vertical, 10)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black.opacity(0.6))
                                }
                                .padding(.bottom, 10)
                            }
                            .frame(width: 350)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
                .searchable(text: $searchText)
            }
            .task {
                await viewModel.fetchPopularMovies()
            }
        }
    }
}

#Preview {
    PopularView()
}

