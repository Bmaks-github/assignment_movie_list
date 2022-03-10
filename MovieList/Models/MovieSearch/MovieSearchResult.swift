//
//  MovieSearchResult.swift
//  MovieList
//
//  Created by Maksym Bura on 08.03.2022.
//

struct MovieSearchResult: Codable {
    let page: Int
    let results: [MovieSearchDetail]?
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
