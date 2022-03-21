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
                "page": page
            ],
            completion: completion
        )
    }
}

