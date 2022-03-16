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
            params: nil) { result in
                switch result {
                case let .success(data):
                    do {
                        let result = try JSONDecoder().decode(MovieGenresList.self, from: data)
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
