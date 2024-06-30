import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = TrendViewModel()
    @ObservedObject private var popularViewModel = PopularViewModel()
    @ObservedObject private var tvViewModel = TvViewModel()

    var body: some View {
        NavigationStack {
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
                        
                        VStack(spacing: 10) {
                            Spacer()
                            Text("Trend")
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: TrendDetailsView(movie: movie)) {
                                        VStack {
                                            ZStack {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { trendResult in
                                                    switch trendResult {
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
                                                    .foregroundColor(.primary)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.horizontal, 10)
                                            }
                                            Spacer()
                                        }
                                        .frame(width: 150)
                                    }
                                    .onAppear {
                                        if movie.id == viewModel.movies.last?.id && viewModel.currentPage < viewModel.totalPages {
                                            Task {
                                                await viewModel.fetchTrendingMovies(page: viewModel.currentPage + 1)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                        }
                        
                        VStack(spacing: 10) {
                            Spacer()
                            Text("TV")
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(tvViewModel.tvShows) { tvShow in
                                    NavigationLink(destination: TvDetailsView(tvShow: tvShow)) {
                                        VStack {
                                            ZStack {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)")) { tvResult in
                                                    switch tvResult {
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
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.center)
                                                .padding(.horizontal, 10)
                                            Spacer()
                                        }
                                        .frame(width: 150)
                                    }
                                    .onAppear {
                                        if tvShow.id == tvViewModel.tvShows.last?.id && tvViewModel.currentPage < tvViewModel.totalPages {
                                            Task {
                                                await tvViewModel.fetchTvShows(page: tvViewModel.currentPage + 1)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                        }
                        
                        VStack(spacing: 10) {
                            Spacer()
                            Text("Popular")
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(popularViewModel.popular) { popular in
                                    NavigationLink(destination: PopularDetailsView(movie: popular)) {
                                        VStack {
                                            ZStack {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(popular.posterPath)")) { popularResult in
                                                    switch popularResult {
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
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.center)
                                                .padding(.horizontal, 10)
                                            Spacer()
                                        }
                                        .frame(width: 150)
                                    }
                                    .onAppear {
                                        if popular.id == popularViewModel.popular.last?.id && popularViewModel.currentPage < popularViewModel.totalPages {
                                            Task {
                                                await popularViewModel.fetchPopularMovies(page: popularViewModel.currentPage + 1)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                        }
                    }
                }
                .task {
                    await viewModel.fetchTrendingMovies()
                    await popularViewModel.fetchPopularMovies()
                    await tvViewModel.fetchTvShows()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

