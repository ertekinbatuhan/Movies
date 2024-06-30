//
//  TvView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct TvView: View {
    
    @ObservedObject var viewModel = MovieViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.tvShows) { tvShow in
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack(alignment: .bottomTrailing) {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)")) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: UIScreen.main.bounds.width - 32, height: 350)
                                                .cornerRadius(15)
                                                .shadow(radius: 4)
                                        default:
                                            ProgressView()
                                                .frame(width: UIScreen.main.bounds.width - 32, height: 350)
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        }
                                    }.navigationTitle("Tv Shows")
                                    .searchable(text: $searchText)
                                    .cornerRadius(15)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(tvShow.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(Color.black.opacity(0.7))
                                            .cornerRadius(10)
                                            .shadow(radius: 4)
                                        
                                        HStack {
                                            RatingView(rating: tvShow.voteAverage)
                                                .foregroundColor(.yellow)
                                                .padding(.horizontal, 10)
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal, 10)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 8)
                                    .padding(.trailing, 8)
                                }
                                .frame(width: UIScreen.main.bounds.width - 32, height: 350)
                            }
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .task {
                await viewModel.fetchTvShows()
        }
        }
    }
}

#Preview {
    TvView()
}

