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
    private let movieDetail: MovieSearchDetail
    
    init(
        router: MovieDetailRouterProtocol,
        movieDetail: MovieSearchDetail
    ) {
        self.router = router
        self.movieDetail = movieDetail
    }
    
    func getImageUrl(for posterPath: String?) -> URL? {
        guard let posterPath = posterPath else { return nil }

        let url = URL(string: Constants.Domain.imageBaseUrl + posterPath)
        
        return url
    }
}

// MARK:  MovieDetailViewModelProtocol
extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    func viewLoaded() {
        view?.update(with: .init(
            title: movieDetail.title,
            rightNavBarText: String(format: "%.1f %@", movieDetail.voteAverage, "\u{1F3C6}"),
            viewModel: .init(
                posterImageUrl: getImageUrl(for: movieDetail.posterPath),
                overviewText: movieDetail.overview
            ))
        )
    }
}
