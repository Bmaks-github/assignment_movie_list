//
//  MovieSearchDetail.swift
//  MovieList
//
//  Created by Maksym Bura on 08.03.2022.
//

struct MovieDetail: Codable {
    let id: Int
    let adult: Bool
    let overview: String
    let genreIds: [Int]
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
