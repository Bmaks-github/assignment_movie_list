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
        let searchService = SearchService()
        let moviesService = MoviesService()
        let genresService = GenresService()
        let movieListPaginator = MovieListPaginator(searchService: searchService, movieService: moviesService)
        let movieListWorker = MovieListWorker()
        
        let viewModel = MovieListViewModel(
            router: router,
            worker: movieListWorker,
            genresService: genresService,
            movieListPaginator: movieListPaginator
        )
        
        let controller = MovieListViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
