//
//  MovieService.swift
//  MovieList
//
//  Created by Maksym Bura on 10.03.2022.
//

import Foundation

// sourcery: AutoMockable
protocol MoviesServiceProtocol {
    func getPopularMovies(page: String, completion: @escaping ResultHandler<MovieSearchResult>)
}

final class MoviesService: ServiceProtocol {
    var networkProvider: NetworkProvider {
        .init(path: "/movie")
    }
}

extension MoviesService: MoviesServiceProtocol {
    
    func getPopularMovies(page: String, completion: @escaping ResultHandler<MovieSearchResult>) {
        networkProvider.getData(
            with: "/popular",
            params: [
                URLQueryItem(name: "page", value: page)
            ]
        ) { result in
            switch result {
            case let .success(data):
                do {
                    let result = try JSONDecoder().decode(MovieSearchResult.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NSError.commonError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

