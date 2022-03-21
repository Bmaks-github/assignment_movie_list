//
//  MovieListService.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import Foundation

// sourcery: AutoMockable
protocol GenresServiceProtocol {
    func getGenresList(completion: @escaping ResultHandler<MovieGenresList>)
}

final class GenresService: ServiceProtocol {
    var networkProvider: NetworkProvider {
        .init(path: "/genre")
    }
}

extension GenresService: GenresServiceProtocol {
    
    func getGenresList(completion: @escaping ResultHandler<MovieGenresList>) {
        networkProvider.getData(
            with: "/movie/list",
            params: nil,
            completion: completion
        )
    }
}
