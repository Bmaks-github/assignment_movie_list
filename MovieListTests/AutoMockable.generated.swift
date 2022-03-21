// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

// Дефолтный AutoMockable не позволяет положить моки в test target
// Добавляем строку с импортом


@testable import MovieList

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif













public final class GenresServiceProtocolMock: GenresServiceProtocol {
    public init() {}

    //MARK: - getGenresList

    public var getGenresListCompletionCallsCount = 0
    public var getGenresListCompletionReceivedCompletion: (ResultHandler<MovieGenresList>)?
    public var getGenresListCompletionClosure: ((@escaping ResultHandler<MovieGenresList>) -> Void)?

    public func getGenresList(completion: @escaping ResultHandler<MovieGenresList>) {
        getGenresListCompletionCallsCount += 1
        getGenresListCompletionReceivedCompletion = completion
        getGenresListCompletionClosure?(completion)
    }

}
public final class LoaderPresentableMock: LoaderPresentable {
    public init() {}

    //MARK: - setLoading

    public var setLoadingCallsCount = 0
    public var setLoadingReceivedLoading: Bool?
    public var setLoadingClosure: ((Bool) -> Void)?

    public func setLoading(_ loading: Bool) {
        setLoadingCallsCount += 1
        setLoadingReceivedLoading = loading
        setLoadingClosure?(loading)
    }

}
public final class MovieDetailRouterProtocolMock: MovieDetailRouterProtocol {
    public init() {}

}
public final class MovieDetailViewProtocolMock: MovieDetailViewProtocol {
    public init() {}

    //MARK: - update

    public var updateWithCallsCount = 0
    public var updateWithReceivedModel: MovieDetailViewController.Model?
    public var updateWithClosure: ((MovieDetailViewController.Model) -> Void)?

    public func update(with model: MovieDetailViewController.Model) {
        updateWithCallsCount += 1
        updateWithReceivedModel = model
        updateWithClosure?(model)
    }

    //MARK: - setLoading

    public var setLoadingCallsCount = 0
    public var setLoadingReceivedLoading: Bool?
    public var setLoadingClosure: ((Bool) -> Void)?

    public func setLoading(_ loading: Bool) {
        setLoadingCallsCount += 1
        setLoadingReceivedLoading = loading
        setLoadingClosure?(loading)
    }

}
public final class MovieListPaginatorProtocolMock: MovieListPaginatorProtocol {
    public init() {}

    //MARK: - selectMode

    public var selectModeModeCallsCount = 0
    public var selectModeModeReceivedMode: MovieListPaginator.Mode?
    public var selectModeModeClosure: ((MovieListPaginator.Mode) -> Void)?

    public func selectMode(mode: MovieListPaginator.Mode) {
        selectModeModeCallsCount += 1
        selectModeModeReceivedMode = mode
        selectModeModeClosure?(mode)
    }

    //MARK: - fetchFirstMovies

    public var fetchFirstMoviesCompletionCallsCount = 0
    public var fetchFirstMoviesCompletionReceivedCompletion: (ResultHandler<[MovieDetail]>)?
    public var fetchFirstMoviesCompletionClosure: ((@escaping ResultHandler<[MovieDetail]>) -> Void)?

    public func fetchFirstMovies(completion: @escaping ResultHandler<[MovieDetail]>) {
        fetchFirstMoviesCompletionCallsCount += 1
        fetchFirstMoviesCompletionReceivedCompletion = completion
        fetchFirstMoviesCompletionClosure?(completion)
    }

    //MARK: - fetchNextMovies

    public var fetchNextMoviesCompletionCallsCount = 0
    public var fetchNextMoviesCompletionReceivedCompletion: (ResultHandler<[MovieDetail]>)?
    public var fetchNextMoviesCompletionClosure: ((@escaping ResultHandler<[MovieDetail]>) -> Void)?

    public func fetchNextMovies(completion: @escaping ResultHandler<[MovieDetail]>) {
        fetchNextMoviesCompletionCallsCount += 1
        fetchNextMoviesCompletionReceivedCompletion = completion
        fetchNextMoviesCompletionClosure?(completion)
    }

}
public final class MovieListRouterProtocolMock: MovieListRouterProtocol {
    public init() {}

    //MARK: - openMovieDetail

    public var openMovieDetailWithCallsCount = 0
    public var openMovieDetailWithReceivedMovieDetail: MovieDetail?
    public var openMovieDetailWithClosure: ((MovieDetail) -> Void)?

    public func openMovieDetail(with movieDetail: MovieDetail) {
        openMovieDetailWithCallsCount += 1
        openMovieDetailWithReceivedMovieDetail = movieDetail
        openMovieDetailWithClosure?(movieDetail)
    }

}
public final class MovieListViewProtocolMock: MovieListViewProtocol {
    public init() {}

    //MARK: - update

    public var updateWithCallsCount = 0
    public var updateWithReceivedState: MovieListView.State?
    public var updateWithClosure: ((MovieListView.State) -> Void)?

    public func update(with state: MovieListView.State) {
        updateWithCallsCount += 1
        updateWithReceivedState = state
        updateWithClosure?(state)
    }

    //MARK: - setLoading

    public var setLoadingCallsCount = 0
    public var setLoadingReceivedLoading: Bool?
    public var setLoadingClosure: ((Bool) -> Void)?

    public func setLoading(_ loading: Bool) {
        setLoadingCallsCount += 1
        setLoadingReceivedLoading = loading
        setLoadingClosure?(loading)
    }

}
public final class MovieParamsParserProtocolMock: MovieParamsParserProtocol {
    public init() {}

    //MARK: - getGenreNamesList

    public var getGenreNamesListForGenresListCallsCount = 0
    public var getGenreNamesListForGenresListReceivedArgs: (genreIds: [Int], genresList: MovieGenresList?)?
    public var getGenreNamesListForGenresListReturnValue: String!
    public var getGenreNamesListForGenresListClosure: (([Int], MovieGenresList?) -> String)?

    public func getGenreNamesList(for genreIds: [Int], genresList: MovieGenresList?) -> String {
        getGenreNamesListForGenresListCallsCount += 1
        getGenreNamesListForGenresListReceivedArgs = (genreIds: genreIds, genresList: genresList)
        return getGenreNamesListForGenresListClosure.map({ $0(genreIds, genresList) }) ?? getGenreNamesListForGenresListReturnValue
    }

    //MARK: - getMarkBarValue

    public var getMarkBarValueMarkCallsCount = 0
    public var getMarkBarValueMarkReceivedMark: Double?
    public var getMarkBarValueMarkReturnValue: Float!
    public var getMarkBarValueMarkClosure: ((Double) -> Float)?

    public func getMarkBarValue(mark: Double) -> Float {
        getMarkBarValueMarkCallsCount += 1
        getMarkBarValueMarkReceivedMark = mark
        return getMarkBarValueMarkClosure.map({ $0(mark) }) ?? getMarkBarValueMarkReturnValue
    }

    //MARK: - getImageUrl

    public var getImageUrlForCallsCount = 0
    public var getImageUrlForReceivedPosterPath: String?
    public var getImageUrlForReturnValue: URL?
    public var getImageUrlForClosure: ((String?) -> URL?)?

    public func getImageUrl(for posterPath: String?) -> URL? {
        getImageUrlForCallsCount += 1
        getImageUrlForReceivedPosterPath = posterPath
        return getImageUrlForClosure.map({ $0(posterPath) }) ?? getImageUrlForReturnValue
    }

}
public final class MoviesServiceProtocolMock: MoviesServiceProtocol {
    public init() {}

    //MARK: - getPopularMovies

    public var getPopularMoviesPageCompletionCallsCount = 0
    public var getPopularMoviesPageCompletionReceivedArgs: (page: String, completion: ResultHandler<MovieSearchResult>)?
    public var getPopularMoviesPageCompletionClosure: ((String, @escaping ResultHandler<MovieSearchResult>) -> Void)?

    public func getPopularMovies(page: String, completion: @escaping ResultHandler<MovieSearchResult>) {
        getPopularMoviesPageCompletionCallsCount += 1
        getPopularMoviesPageCompletionReceivedArgs = (page: page, completion: completion)
        getPopularMoviesPageCompletionClosure?(page, completion)
    }

}
public final class SearchServiceProtocolMock: SearchServiceProtocol {
    public init() {}

    //MARK: - searchMovieList

    public var searchMovieListMovieNamePageCompletionCallsCount = 0
    public var searchMovieListMovieNamePageCompletionReceivedArgs: (movieName: String, page: String, completion: ResultHandler<MovieSearchResult>)?
    public var searchMovieListMovieNamePageCompletionClosure: ((String, String, @escaping ResultHandler<MovieSearchResult>) -> Void)?

    public func searchMovieList(movieName: String, page: String, completion: @escaping ResultHandler<MovieSearchResult>) {
        searchMovieListMovieNamePageCompletionCallsCount += 1
        searchMovieListMovieNamePageCompletionReceivedArgs = (movieName: movieName, page: page, completion: completion)
        searchMovieListMovieNamePageCompletionClosure?(movieName, page, completion)
    }

}
public final class TransitionableMock: Transitionable {
    public init() {}

    //MARK: - push

    public var pushControllerAnimatedCallsCount = 0
    public var pushControllerAnimatedReceivedArgs: (controller: UIViewController, animated: Bool)?
    public var pushControllerAnimatedClosure: ((UIViewController, Bool) -> Void)?

    public func push(controller: UIViewController, animated: Bool) {
        pushControllerAnimatedCallsCount += 1
        pushControllerAnimatedReceivedArgs = (controller: controller, animated: animated)
        pushControllerAnimatedClosure?(controller, animated)
    }

    //MARK: - pop

    public var popAnimatedCallsCount = 0
    public var popAnimatedReceivedAnimated: Bool?
    public var popAnimatedClosure: ((Bool) -> Void)?

    public func pop(animated: Bool) {
        popAnimatedCallsCount += 1
        popAnimatedReceivedAnimated = animated
        popAnimatedClosure?(animated)
    }

}
