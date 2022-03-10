////
////  MovieListService.swift
////  MovieList
////
////  Created by Maksym Bura on 07.03.2022.
////
//
//import Foundation
//
//protocol MovieImageServiceProtocol {
//    func getImage(posterPath: String, completion: @escaping ResultHandler<Data>)
//}
//
//final class MovieImageService {
//    private let endpointURL: String = "https://image.tmdb.org/t/p/w1280"
//
//    private func constructUrlByAdding(posterPath: String) -> URL? {
//        let url = URL(string: endpointURL + posterPath)
//
//        return url
//    }
//}
//
//extension MovieImageService: MovieImageServiceProtocol {
//
//    /// URL Example
//    /// https://image.tmdb.org/t/p/w1280/zlyhKMi2aLk25nOHnNm43MpZMtQ.jpg
//    func getImage(posterPath: String, completion: @escaping ResultHandler<Data>) {
//        guard let url = constructUrlByAdding(posterPath: posterPath) else {
//            return completion(.failure(NSError.commonError))
//        }
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else {
//                return completion(.failure(NSError.commonError))
//            }
//
//            completion(.success(data))
//        }
//
//        task.resume()
//    }
//}
