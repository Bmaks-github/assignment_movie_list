//
//  MovieListWorker.swift
//  MovieList
//
//  Created by Maksym Bura on 15.03.2022.
//

import Foundation

// sourcery: AutoMockable
protocol MovieParamsParserProtocol {
    func getGenreNamesList(for genreIds: [Int], genresList: MovieGenresList?) -> String
    func getMarkBarValue(mark: Double) -> Float
    func getImageUrl(for posterPath: String?) -> URL?
}

final class MovieParamsParser: MovieParamsParserProtocol {
    func getGenreNamesList(for genreIds: [Int], genresList: MovieGenresList?) -> String {
        var resultGenreList = [String?]()
        
        for genreId in genreIds {
            let genre = genresList?.genres.filter { $0.id == genreId }.first
            resultGenreList.append(genre?.name)
        }
        
        let resultList = resultGenreList.compactMap { $0 }.joined(separator: ", ")
        
        return resultList
    }
    
    func getMarkBarValue(mark: Double) -> Float {
        let dividerValue: Float = 10.0
        
        return Float(mark) / dividerValue
    }
    
    func getImageUrl(for posterPath: String?) -> URL? {
        guard let posterPath = posterPath else { return nil }

        let url = URL(string: Constants.Domain.imageBaseUrl + posterPath)
        
        return url
    }
}
