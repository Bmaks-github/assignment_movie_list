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
                "query": movieName,
                "page": page
            ],
            completion: completion
        )
    }
}
