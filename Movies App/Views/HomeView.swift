//
//  ContentView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = MovieViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Image("houseofdragon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .shadow(radius: 10)
                    
                    // Header bar for Popular Movies
                    VStack(spacing: 10) {
                        Spacer()
                        
                        Text("Trend")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.movies) { movie in
                                VStack {
                                    ZStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { movieImage in
                                            switch movieImage {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 150, height: 250)
                                                    .cornerRadius(15)
                                            default:
                                                ProgressView()
                                                    .frame(width: 150, height: 250)
                                            }
                                        }
                                        .cornerRadius(15)
                                        .shadow(radius: 4)
                                    }
                                    
                                    Spacer()
                                    if let title = movie.title {
                                        Text(title)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 10)
                                    }
                                    Spacer()
                                }
                                .frame(width: 150)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    
                    // Header bar for Trending TV Shows
                    VStack(spacing: 10) {
                        Spacer()
                        
                        Text("TV")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.tvShows) { tvShow in
                                VStack {
                                    ZStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)")) { tvShowImage in
                                            switch tvShowImage {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 150, height: 250)
                                                    .cornerRadius(15)
                                            default:
                                                ProgressView()
                                                    .frame(width: 150, height: 250)
                                            }
                                        }
                                        .cornerRadius(15)
                                        .shadow(radius: 4)
                                    }
                                    
                                    Spacer()
                                    Text(tvShow.name)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 10)
                                    Spacer()
                                }
                                .frame(width: 150)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    
                    // Header bar for Popular TV Shows
                    VStack(spacing: 10) {
                        Spacer()
                        
                        Text("Popular")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                        ForEach(viewModel.popular) { popular in
                            VStack {
                                ZStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(popular.posterPath)")) {tvShowImage in
                                        switch tvShowImage {
                                            case .success(let image):
                                                image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                    .frame(width: 150, height: 250)
                                                        .cornerRadius(15)
                                                    default:
                                                    ProgressView()
                                                        .frame(width: 150, height: 250)
                                                              }
                                                          }
                                                          .cornerRadius(15)
                                                          .shadow(radius: 4)
                                                      }
                                                      
                                    Spacer()
                                    Text(popular.title)
                                                .font(.caption)
                                                    .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                        .padding(.horizontal, 10)
                                                      Spacer()
                                                  }
                                                  .frame(width: 150)
                                              }
                                          }
                                          .padding(.horizontal)
                                          .padding(.top, 10)
                                      }
                }
            }
        }
        .task {
            await viewModel.fetchTrendingMovies()
            await viewModel.fetchTvShows()
            await viewModel.fetchPopularMovies()
        }
    }
}


#Preview {
    HomeView()
}

