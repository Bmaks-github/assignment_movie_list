//
//  Created by Maksym Bura on 09.03.2022.
//

import Foundation

protocol MovieDetailViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class MovieDetailViewModel {
    weak var view: MovieDetailViewProtocol?
    
    private let router: MovieDetailRouterProtocol
    private let worker: MovieListWorkerProtocol
    private let movieDetail: MovieDetail
    
    init(
        router: MovieDetailRouterProtocol,
        worker: MovieListWorkerProtocol,
        movieDetail: MovieDetail
    ) {
        self.router = router
        self.worker = worker
        self.movieDetail = movieDetail
    }
}

// MARK:  MovieDetailViewModelProtocol
extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    func viewLoaded() {
        let rightNavBarText = String(format: "%.1f %@", movieDetail.voteAverage, "\u{1F3C6}")
        let imageUrl = worker.getImageUrl(for: movieDetail.posterPath)
        
        view?.update(with: .init(
            title: movieDetail.title,
            rightNavBarText: rightNavBarText,
            viewModel: .init(
                posterImageUrl: imageUrl,
                overviewText: movieDetail.overview
            ))
        )
    }
}
