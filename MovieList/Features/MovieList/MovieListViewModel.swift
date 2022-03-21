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
    private let worker: MovieParamsParserProtocol
    private let genresService: GenresServiceProtocol
    private let movieListPaginator: MovieListPaginatorProtocol
    
    private(set) var sections: [SectionSource] = []
    private(set) var genresList: MovieGenresList?
    private var subjects: [MovieDetail] = []
    private var debounceTimer: Timer?
    
    init(
        router: MovieListRouterProtocol,
        worker: MovieParamsParserProtocol,
        genresService: GenresServiceProtocol,
        movieListPaginator: MovieListPaginatorProtocol
    ) {
        self.router = router
        self.worker = worker
        self.genresService = genresService
        self.movieListPaginator = movieListPaginator
    }
}

// MARK: -  Private methods
private extension MovieListViewModel {
    func createCells() -> [SectionSource.CellSource] {
        var cells: [SectionSource.CellSource] = []
        cells.append(
            contentsOf:
                subjects.compactMap { movieSearchDetail in
                    
                    let imageUrl = worker.getImageUrl(for: movieSearchDetail.posterPath)
                    let genreListString = worker.getGenreNamesList(for: movieSearchDetail.genreIds, genresList: genresList).uppercased()
                    let markBarValue = worker.getMarkBarValue(mark: movieSearchDetail.voteAverage)
                    
                    return SectionSource.CellSource(
                        model: MovieListTableViewCell.Model(
                            title: movieSearchDetail.title,
                            imageUrl: imageUrl,
                            genre: genreListString,
                            markBarValue: markBarValue,
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
        view?.update(with: .hasData(sections))
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
        genresService.getGenresList { [weak self] result in
            self?.view?.setLoading(false)
            
            switch result {
            case let .success(list):
                self?.genresList = list
                self?.loadPopularMovies()
            case .failure(_):
                break
            }
        }
    }
    
    func loadPopularMovies() {
        view?.setLoading(true)
        movieListPaginator.selectMode(mode: .popularMovies)
        movieListPaginator.fetchFirstMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.setLoading(false)
                
                switch result {
                case let .success(movies):
                    self?.subjects = movies
                    self?.reloadSections()
                case .failure(_):
                    break
                }
            }
        }
    }
}


// MARK: -  MovieListViewModelProtocol

extension MovieListViewModel: MovieListViewModelProtocol {
    func viewLoaded() {
        loadMovieGenresList()
    }
    
    func searchBarTextChanged(text: String?) {
        guard let text = text else { return }
        
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: Constants.Debouncer.delayInSeconds, repeats: false) { [weak self]  _ in
            let mode: MovieListPaginator.Mode = text.isEmpty ? .popularMovies : .searchMovie(text)
            
            self?.movieListPaginator.selectMode(mode: mode)
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
