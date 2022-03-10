//
//  MovieListService.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import Foundation

protocol GenresServiceProtocol {
    func getGenresList(completion: @escaping ResultHandler<MovieGenresList>)
}

final class GenresService {
    let networkProvider: NetworkProvider
    
    init() {
        networkProvider = .init(path: "/genre")
    }

//    private var endpointURL: String {
//        let path: String = "/genre/movie/list"
//        
//        return Constants.Domain.baseUrl + path
//    }
//
//    private func constructBasicUrl() -> URL? {
//        var urlComps = URLComponents(string: endpointURL)
//        
//        let queryItems = [URLQueryItem(name: "api_key", value: Constants.Domain.apiKey)]
//
//        urlComps?.queryItems = queryItems
//        
//        return urlComps?.url
//    }
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
