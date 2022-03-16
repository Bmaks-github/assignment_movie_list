//
//  LoaderPresentable.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

// sourcery: AutoMockable
protocol LoaderPresentable: AnyObject {
    func setLoading(_ loading: Bool)
}
