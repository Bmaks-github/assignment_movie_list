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
        
        let viewModel = MovieDetailViewModel(
            router: router,
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
        let movieSearchDetail: MovieSearchDetail
    }
}
