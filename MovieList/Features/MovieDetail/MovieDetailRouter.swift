//
//  Created by Maksym Bura on 09.03.2022.
//

// sourcery: AutoMockable
protocol MovieDetailRouterProtocol: AnyObject { }

final class MovieDetailRouter: MovieDetailRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
}
