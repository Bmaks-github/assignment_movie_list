//
//  MovieListService.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import Foundation

// sourcery: AutoMockable
protocol SearchServiceProtocol {
    func searchMovieList(movieName: String, page: String, completion: @escaping ResultHandler<MovieSearchResult>)
}

final class SearchService: ServiceProtocol {
    var networkProvider: NetworkProvider {
        .init(path: "/search")
    }
}

extension SearchService: SearchServiceProtocol {
    
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
}
