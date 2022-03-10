//
//  Created by Maksym Bura on 03.03.2022.
//

import UIKit

protocol MovieListFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class MovieListFactory: MovieListFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = MovieListRouter(transitionHandler: transitionHandler)
        let movieSearchService = SearchService()
//        let movieImageService = MovieImageService()
        let movieGenresService = GenresService()
        let movieListPaginator = MovieListPaginator(service: movieSearchService)
        
        let viewModel = MovieListViewModel(
            router: router,
//            movieSearchService: movieSearchService,
//            movieImageService: movieImageService,
            movieGenresService: movieGenresService,
            movieListPaginator: movieListPaginator
        )
        
        let controller = MovieListViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
