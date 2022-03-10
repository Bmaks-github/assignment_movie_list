//
//  MovieListPaginator.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import Foundation

// sourcery: AutoMockable
protocol MovieListPaginatorProtocol: AnyObject {
    func selectSearchMovieFilter(movieName: String)
    func fetchFirstMovies(completion: @escaping ResultHandler<[MovieSearchDetail]>)
//    func fetchDocuments(completion: @escaping ResultHandler<[Document]>)
    func fetchNextMovies(completion: @escaping ResultHandler<[MovieSearchDetail]>)
}

final class MovieListPaginator: MovieListPaginatorProtocol {
    // MARK: - Properties

//    private let constants = PaginatorConstants()
    private var totalPagesCount: Int = 1
    private var currentPage: Int = 1

    private var movieName: String = ""
//    private var documentTypes: [DocumentType]
//    private var fromDate: Date?
//    private var toDate: Date?
//    private var contractorInn: String?

    private var isFetching: Bool = false

    // MARK: - Dependencies

    private let service: SearchServiceProtocol

    // MARK: - Lifecycle

    init(
        service: SearchServiceProtocol
    ) {
        self.service = service
//
//        documentTypes = constants.standartDocumentTypes
//
//        if isDocumentFlowInvoicesEnabled {
//            documentTypes.append(contentsOf: constants.invoicesDocumentTypes)
//        }
    }

    // MARK: - DocumentFlowDashboardPaginatorProtocol

    func selectSearchMovieFilter(movieName: String) {
//        self.documentTypes = documentTypes
//        fromDate = datePeriod?.fromDate
//        toDate = datePeriod?.toDate
//        self.contractorInn = contractorInn

        // сброс пагинатора для новых типов документов и фильтров
        self.movieName = movieName
        isFetching = false
//        currentPage = constants.startingPage
//        didChangeBlock?()
    }

    func fetchFirstMovies(completion: @escaping ResultHandler<[MovieSearchDetail]>) {
        currentPage = 1
        
        searchMovie(
            page: currentPage,
            fetchNewPage: false,
            completion: completion
        )
    }

//    func fetchMovies(completion: @escaping ResultHandler<MovieSearchResult>) {
//        getDocuments(
//            page: currentPage,
//            perPageResults: resultsPerPageCount,
//            docTypes: documentTypes,
//            fetchNewPage: false,
//            completion: completion
//        )
//    }

    func fetchNextMovies(completion: @escaping ResultHandler<[MovieSearchDetail]>) {
        searchMovie(
            page: currentPage + 1,
            fetchNewPage: true,
            completion: completion
        )
    }
}

private extension MovieListPaginator {
    // MARK: - Service private methods

    func searchMovie(
        page: Int,
        fetchNewPage: Bool,
        completion: @escaping ResultHandler<[MovieSearchDetail]>
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

        service.searchMovieList(
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
    }

    func parseResult(
        page: Int,
        fetchNewPage: Bool,
        result: Result<MovieSearchResult, Error>,
        completion: @escaping ResultHandler<[MovieSearchDetail]>
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

//private extension DocumentFlowDashboardPaginator {
//    struct PaginatorConstants {
//        let resultsPerPage: Int = 10
//        let startingPage: Int = 1
//        let standartDocumentTypes: [DocumentType] = [.acts, .calcInvoices, .consignmentNotes]
//        let invoicesDocumentTypes: [DocumentType] = [.invoiceIncoming, .invoiceOutcoming]
//    }
//}

