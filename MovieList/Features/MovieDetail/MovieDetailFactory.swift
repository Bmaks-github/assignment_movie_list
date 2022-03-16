//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

protocol MovieDetailFactoryProtocol: AnyObject {
    func create(context: MovieDetailFactory.Context) -> UIViewController
}

final class MovieDetailFactory: MovieDetailFactoryProtocol {
    func create(context: Context) -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = MovieDetailRouter(transitionHandler: transitionHandler)
        let worker = MovieListWorker()
        
        let viewModel = MovieDetailViewModel(
            router: router,
            worker: worker,
            movieDetail: context.movieSearchDetail
        )
        
        let controller = MovieDetailViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}

extension MovieDetailFactory {
    struct Context {
        let movieSearchDetail: MovieDetail
    }
}
