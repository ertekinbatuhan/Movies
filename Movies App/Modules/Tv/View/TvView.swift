//
//  TvView.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct TvView: View {
    
    @ObservedObject var viewModel = TvViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(TvHelper.filteredTvShows(tvShows: viewModel.tvShows, searchText: searchText)) { tvShow in
                        NavigationLink(destination: TvDetailsView(tvShow: tvShow)) {
                            VStack(alignment: .leading, spacing: 10) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")")) { tvResult in
                                    switch tvResult {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width - 32, height: 350)
                                            .cornerRadius(15)
                                            .clipped()
                                    default:
                                        ProgressView()
                                            .frame(width: UIScreen.main.bounds.width - 32, height: 350)
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    }
                                }
                                .cornerRadius(15)
                                .shadow(radius: 4)
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(tvShow.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(Color.white.opacity(0.8))
                                            .cornerRadius(10)
                                            .shadow(radius: 4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top,7)
                                    }
                                    .padding(.leading, 10)

                                    Spacer()

                                    VStack(alignment: .trailing) {
                                        RatingView(rating: tvShow.voteAverage)
                                            .padding(.horizontal, 10)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(15)
                            }
                            .padding(.horizontal, 16)
                        }
                        .onAppear {
                            if tvShow.id == viewModel.tvShows.last?.id {
                                Task {
                                    await viewModel.fetchTvShows(page: viewModel.currentPage + 1)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Tv Shows")
            .searchable(text: $searchText)
            .task {
                await viewModel.fetchTvShows()
            }
        }
    }
}

#Preview {
    TvView()
}

