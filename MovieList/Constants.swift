//
//  Constants.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import CoreGraphics

enum Constants {
    enum Domain {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w1280"
        static let apiKey: String = "815b63b537c380370911f6cb083031b0"
    }
    
    enum Debouncer {
        static let delayInSeconds: Double = 0.6
    }
}
