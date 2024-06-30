import SwiftUI

struct PopularView: View {
    @ObservedObject var viewModel = MovieViewModel()
    @State private var searchText = ""
    @State private var selectedMovie: PopularResult? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.popular) { movie in
                        NavigationLink(destination: DetailsView(movie: movie)) {
                            VStack {
                                ZStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { phase in
                                        switch phase {
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
                    }
                }
                .padding()
                .searchable(text: $searchText)
            }
            .task {
                await viewModel.fetchPopularMovies()
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    PopularView()
}

