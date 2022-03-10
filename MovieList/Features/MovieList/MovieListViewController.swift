//
//  Created by Maksym Bura on 03.03.2022.
//

import SnapKit
import UIKit

// sourcery: AutoMockable
protocol MovieListViewProtocol: LoaderPresentable {
    func update(with model: MovieListView.Model)
}

final class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModelProtocol
    private lazy var customView = MovieListView(viewModel: viewModel)
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .darkContent
//    }
    
//    private lazy var navigationBar = UINavigationBar().with {
//        let screenSize: CGRect = UIScreen.main.bounds
//        $0.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 44)
//
//        let navItem = UINavigationItem(title: "Movies")
//        $0.setItems([navItem], animated: false)
//
////        let navBarAppearance = UINavigationBarAppearance()
////        navBarAppearance.configureWithOpaqueBackground()
////        navBarAppearance.backgroundColor = .yellow
////
////        UINavigationBar.appearance().standardAppearance = navBarAppearance
//    }
    
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

        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.init(red: 15.0/256.0, green: 15.0/256.0, blue: 15.0/256.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.topItem?.title = "🍿 Movies"
        
        viewModel.viewLoaded()
    }
    
//    func setupSubviews() {
//        view.addSubview(customView)
//    }
//
//    func setupConstraints() {
//        customView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }
//    }
}

// MARK: - MovieListViewProtocol
extension MovieListViewController: MovieListViewProtocol {
    func update(with model: MovieListView.Model) {
        customView.update(with: .hasData)
    }
}
