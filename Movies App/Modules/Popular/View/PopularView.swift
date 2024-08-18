//
//  PopularView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct PopularView: View {
    
    @ObservedObject var viewModel = PopularViewModel()
    @State private var searchText = ""
   
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(PopularHelper.filteredPopularResults(results: viewModel.popular, searchText: searchText)) { movie in
                        NavigationLink(destination: PopularDetailsView(movie: movie)) {
                            VStack {
                                ZStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { movie in
                                        switch movie {
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
                                                
                                                HStack(spacing: 5) {
                                                    RatingView(rating: movie.voteAverage)
                                                        .foregroundColor(.yellow)
                                                        .padding(.horizontal, 10)
                                                }
                                                                                                
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
                        .onAppear {
                            if movie.id == viewModel.popular.last?.id {
                                Task {
                                    await viewModel.fetchPopularMovies(page: viewModel.currentPage + 1)
                                }
                            }
                        }
                    }
                }
                .padding()
                .searchable(text: $searchText)
            }
            .task {
                await viewModel.fetchPopularMovies(page: 1)
            }
            .navigationTitle("Popular Movies")
        }
    }
}

#Preview {
    PopularView()
}

