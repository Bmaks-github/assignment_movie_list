//
//  MovieListPaginator.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import Foundation

// sourcery: AutoMockable
protocol MovieListPaginatorProtocol: AnyObject {
    func selectMode(mode: MovieListPaginator.Mode)
    func fetchFirstMovies(completion: @escaping ResultHandler<[MovieDetail]>)
    func fetchNextMovies(completion: @escaping ResultHandler<[MovieDetail]>)
}

final class MovieListPaginator {
    // MARK: - Properties

    private var totalPagesCount: Int = 1
    private var currentPage: Int = 1
    private var movieName: String = ""
    private var isFetching: Bool = false
    private var activeMode: Mode = .popularMovies

    // MARK: - Dependencies

    private let searchService: SearchServiceProtocol
    private let movieService: MoviesServiceProtocol

    // MARK: - Lifecycle

    init(
        searchService: SearchServiceProtocol,
        movieService: MoviesServiceProtocol
    ) {
        self.searchService = searchService
        self.movieService = movieService
    }
}

// MARK: - MovieListPaginatorProtocol

extension MovieListPaginator: MovieListPaginatorProtocol {
    func selectMode(mode: Mode) {
        activeMode = mode
        isFetching = false
    }
    
    func fetchFirstMovies(completion: @escaping ResultHandler<[MovieDetail]>) {
        currentPage = 1
        
        fetchMovie(
            page: currentPage,
            fetchNewPage: false,
            completion: completion
        )
    }

    func fetchNextMovies(completion: @escaping ResultHandler<[MovieDetail]>) {
        fetchMovie(
            page: currentPage + 1,
            fetchNewPage: true,
            completion: completion
        )
    }
}

// MARK: - Private methods

private extension MovieListPaginator {
    func fetchMovie(
        page: Int,
        fetchNewPage: Bool,
        completion: @escaping ResultHandler<[MovieDetail]>
    ) {
        if fetchNewPage, currentPage > totalPagesCount {
            return
        }

        if isFetching {
            return
        } else {
            isFetching = true
        }
        
        let pageString = String(page)

        switch activeMode {
        case let .searchMovie(movieName):
            searchService.searchMovieList(
                movieName: movieName,
                page: pageString
            ) { [weak self] result in
                    self?.isFetching = false

                    self?.parseResult(
                        page: page,
                        fetchNewPage: fetchNewPage,
                        result: result,
                        completion: completion
                    )
                }
        case .popularMovies:
            movieService.getPopularMovies(page: pageString) { [weak self] result in
                self?.isFetching = false

                self?.parseResult(
                    page: page,
                    fetchNewPage: fetchNewPage,
                    result: result,
                    completion: completion
                )
            }
        }
    }

    func parseResult(
        page: Int,
        fetchNewPage: Bool,
        result: Result<MovieSearchResult, Error>,
        completion: @escaping ResultHandler<[MovieDetail]>
    ) {
        switch result {
        case let .success(response):
            totalPagesCount = response.totalPages

            if let results = response.results, results.count > 0, fetchNewPage {
                currentPage = page
            }

            completion(.success(response.results ?? []))
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

extension MovieListPaginator {
    enum Mode: Equatable {
        case searchMovie(String)
        case popularMovies
    }
}
