import SwiftUI

struct PopularDetailsView: View {
    
    let movie: PopularResult
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { popularResult in
                    switch popularResult {
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
                
               
                Text(movie.title)
                    .font(.title)
                    .foregroundColor(.primary)
                
                
                HStack {
                    RatingView(rating: movie.voteAverage)
                    Spacer()
                    Text(movie.releaseDate)
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
        .navigationBarTitle(Text(movie.title.prefix(20)), displayMode: .inline)
    }
}

#Preview {
    PopularDetailsView(movie: PopularResult(
        id: 1,
        adult: false,
        backdropPath: "/abc123.jpg",
        genreIDS: [1, 2, 3],
        originalLanguage: "en",
        originalTitle: "House of Dragon",
        overview: "House of the Dragon is an American fantasy drama television series created by George R. R. Martin and Ryan Condal for HBO. A prequel to Game of Thrones (2011–2019), it is the second television series in the A Song of Ice and Fire franchise. Condal and Miguel Sapochnik served as the showrunners for the first season.",
        popularity: 8.5,
        posterPath: "/def456.jpg",
        releaseDate: "2023-01-01",
        title: "House of Dragon",
        video: false,
        voteAverage: 8.0,
        voteCount: 100
    ))
}

