//
//  Created by Maksym Bura on 03.03.2022.
//

// sourcery: AutoMockable
protocol MovieListRouterProtocol: AnyObject {
    func openMovieDetail(with movieDetail: MovieDetail)
}

final class MovieListRouter: MovieListRouterProtocol {
    private let transitionHandler: Transitionable

    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
    
    func openMovieDetail(with movieDetail: MovieDetail) {
        let controller = MovieDetailFactory().create(context: .init(movieSearchDetail: movieDetail))
        transitionHandler.push(controller: controller, animated: true)
    }
}
