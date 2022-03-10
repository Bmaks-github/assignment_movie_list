//
//  Created by Maksym Bura on 03.03.2022.
//

import Dispatch
import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    var sections: [SectionSource] { get }
    
    func viewLoaded()
    func searchBarTextChanged(text: String?)
    func requestedMoreMovies()
}

final class MovieListViewModel {
    weak var view: MovieListViewProtocol?
    
    private let router: MovieListRouterProtocol
//    private let movieSearchService: MovieSearchServiceProtocol
//    private let movieImageService: MovieImageServiceProtocol
    private let movieGenresService: GenresServiceProtocol
    private let movieListPaginator: MovieListPaginatorProtocol
    
    private(set) var sections: [SectionSource] = []
    private(set) var genresList: MovieGenresList?
    private var subjects: [MovieSearchDetail] = []
    private var debounceTimer: Timer?
    
    init(
        router: MovieListRouterProtocol,
//        movieSearchService: MovieSearchServiceProtocol,
//        movieImageService: MovieImageServiceProtocol,
        movieGenresService: GenresServiceProtocol,
        movieListPaginator: MovieListPaginatorProtocol
    ) {
        self.router = router
//        self.movieSearchService = movieSearchService
//        self.movieImageService = movieImageService
        self.movieGenresService = movieGenresService
        self.movieListPaginator = movieListPaginator
    }
    
    func createCells() -> [SectionSource.CellSource] {
        var cells: [SectionSource.CellSource] = []
        cells.append(
            contentsOf:
                subjects.compactMap { movieSearchDetail in
                    
                    return SectionSource.CellSource(
                        model: MovieListTableViewCell.Model(
                            title: movieSearchDetail.title,
                            imageUrl: getImageUrl(for: movieSearchDetail.posterPath),
                            genre: getGenreNamesList(from: movieSearchDetail.genreIds),
                            markBarValue: convertToMarkBarValue(mark: movieSearchDetail.voteAverage),
                            mark: String(movieSearchDetail.voteAverage)
                        ),
                        onSelectAction: { [weak self] in
                            self?.router.openMovieDetail(with: movieSearchDetail)
                        }
                    )
                }
        )
        
        return cells
    }

    func reloadSections() {
        sections = [createSignerSection()]
        view?.update(with: .init())
    }

    func createSignerSection() -> SectionSource {
        return SectionSource(
            cellsSources: createCells(),
            headerModel: nil,
            footerModel: nil
        )
    }
    
    func loadMovieGenresList() {
        view?.setLoading(true)
        movieGenresService.getGenresList { [weak self] result in
            self?.view?.setLoading(false)
            
            switch result {
            case let .success(list):
                self?.genresList = list
            case .failure(_):
                break
            }
        }
    }
    
    func getGenreNamesList(from genreIds: [Int]) -> String {
        var resultGenreList = [String?]()
        
        for genreId in genreIds {
            let genre = genresList?.genres.filter { $0.id == genreId }.first
            resultGenreList.append(genre?.name)
        }
        
        let resultList = resultGenreList.compactMap { $0 }.joined(separator: ", ")
        
        return resultList
    }
    
    func convertToMarkBarValue(mark: Double) -> Float {
        return Float(mark) / 10.0
    }
    
    func getImageUrl(for posterPath: String?) -> URL? {
        guard let posterPath = posterPath else { return nil }

        let url = URL(string: Constants.Domain.imageBaseUrl + posterPath)
        
        return url
    }
}

// MARK:  MovieListViewModelProtocol
extension MovieListViewModel: MovieListViewModelProtocol {
    func viewLoaded() {
        loadMovieGenresList()
    }
    
    func searchBarTextChanged(text: String?) {
        guard let text = text else { return }
        
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { [weak self]  _ in
            self?.movieListPaginator.selectSearchMovieFilter(movieName: text)
            self?.movieListPaginator.fetchFirstMovies { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(subjects):
                        self?.subjects = subjects
                        self?.reloadSections()
                    case .failure(_):
                        print("")
                    }
                }
            }
        }
    }
    
    func requestedMoreMovies() {
        movieListPaginator.fetchNextMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(subjects):
                    self?.subjects.append(contentsOf: subjects)
                    self?.reloadSections()
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
