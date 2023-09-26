
import Foundation

struct MoviesLoader: MoviesLoading {
    // MARK: - NetworkClient
    private let networkClient: NetworkRouting
    
    init(networkClient: NetworkRouting = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - URL
    private var mostPopularMoviesURL: URL {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_l22vzikh") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    private enum JsonDecodeError: Error {
        case decodeError
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesURL) { result in
            switch result {
                
            case .failure(let error):
                handler(.failure(error))
                
            case .success(let data):
                let jsonMovies = try? JSONDecoder().decode(MostPopularMovies.self, from: data)
                if let jsonMovies = jsonMovies {
                    handler(.success(jsonMovies))
                } else {
                    handler(.failure(JsonDecodeError.decodeError))
                }
            }
        }
    }
    
}

