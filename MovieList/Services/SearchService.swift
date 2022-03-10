//
//  MovieListService.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import Foundation

protocol SearchServiceProtocol {
    func searchMovieList(movieName: String, page: String, completion: @escaping ResultHandler<MovieSearchResult>)
}

final class SearchService {
    let networkProvider: NetworkProvider
    
    init() {
        networkProvider = .init(path: "/search")
    }
}

extension SearchService: SearchServiceProtocol {
    
    /// URL Example
    /// https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
    func searchMovieList(movieName: String, page: String, completion: @escaping ResultHandler<MovieSearchResult>) {
        networkProvider.getData(
            with: "/movie",
            params: [
                URLQueryItem(name: "query", value: movieName),
                URLQueryItem(name: "page", value: page)
            ]) { result in
                switch result {
                case let .success(data):
                    do {
                        let result = try JSONDecoder().decode(MovieSearchResult.self, from: data)
                        completion(.success(result))
                    } catch let jsonError as NSError {
                        completion(.failure(jsonError))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func searchPopularMovies(page: String, completion: @escaping ResultHandler<MovieSearchResult>) {
        networkProvider.getData(
            with: "/movie/",
            params: [
                URLQueryItem(name: "page", value: page)
            ]) { result in
                switch result {
                case let .success(data):
                    do {
                        let result = try JSONDecoder().decode(MovieSearchResult.self, from: data)
                        completion(.success(result))
                    } catch let jsonError as NSError {
                        completion(.failure(jsonError))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
