//
//  Created by Maksym Bura on 03.03.2022.
//

import SnapKit
import UIKit

// sourcery: AutoMockable
protocol MovieListViewProtocol: LoaderPresentable {
    func update(with state: MovieListView.State)
}

final class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModelProtocol
    private lazy var customView = MovieListView(viewModel: viewModel)
    
    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
  
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        viewModel.viewLoaded()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .mlDark
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.mlStandardBoldFont]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("Movies", comment: "")
    }
}

// MARK: - MovieListViewProtocol

extension MovieListViewController: MovieListViewProtocol {
    func update(with state: MovieListView.State) {
        customView.update(with: state)
    }
}
