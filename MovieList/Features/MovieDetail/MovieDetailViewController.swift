//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

// sourcery: AutoMockable
protocol MovieDetailViewProtocol: LoaderPresentable {
    func update(with model: MovieDetailViewController.Model)
}

final class MovieDetailViewController: UIViewController {
    private let viewModel: MovieDetailViewModelProtocol
    private lazy var customView = MovieDetailView()
    
    private lazy var rightBarItemLabel = UILabel().with {
        $0.textColor = .lightGray
    }
    
    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        viewModel.viewLoaded()
    }
}

// MARK: - Private methods

private extension MovieDetailViewController {
    func setupRightNavBarItem(with text: String) {
        rightBarItemLabel.text = text
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarItemLabel)
    }
    
    func setupNavBarTitle(with title: String) {
        self.title = title
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .orange
    }
}

// MARK: - MovieDetailViewProtocol

extension MovieDetailViewController: MovieDetailViewProtocol {
    func update(with model: MovieDetailViewController.Model) {
        setupNavBarTitle(with: model.title)
        setupRightNavBarItem(with: model.rightNavBarText)
        customView.update(with: model.viewModel)
    }
}

extension MovieDetailViewController {
    struct Model {
        let title: String
        let rightNavBarText: String
        let viewModel: MovieDetailView.Model
    }
}
