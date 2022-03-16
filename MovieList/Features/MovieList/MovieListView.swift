//
//  Created by Maksym Bura on 03.03.2022.
//

import SnapKit
import UIKit

final class MovieListView: UIView {
    private let appearance = Appearance()
    private let viewModel: MovieListViewModelProtocol
    private var sections: [SectionSource] = []
    
    private lazy var searchBar = UISearchBar().with {
        $0.barTintColor = .black
        $0.searchTextField.leftView?.tintColor = .mlLightGray
        $0.searchTextField.textColor = .mlLightGray
        $0.searchTextField.placeholder = NSLocalizedString("Search", comment: "")
        $0.delegate = self
    }
    
    private lazy var tableView = UITableView().with {
        $0.register(MovieListTableViewCell.self)
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .mlDarkGray
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.isHidden = true
    }

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel

        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with state: State) {
        switch state {
        case let .hasData(sections):
            self.sections = sections
            
            tableView.isHidden = false
            tableView.reloadData()
        case .noData:
            tableView.isHidden = true
        }
    }
}

// MARK: - Private methods

private extension MovieListView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        addSubview(searchBar)
        addSubview(tableView)
    }

    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(appearance.tableViewLeadingOffset)
            make.trailing.equalToSuperview().inset(appearance.tableViewTrailingInset)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension MovieListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in _: UITableView) -> Int {
        sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cellsSources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section]
            .cellsSources[indexPath.row]
            .model
            .cell(at: indexPath, for: tableView)
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section]
            .cellsSources[indexPath.row]
            .onSelectAction?()
    }
}

// MARK: - UISearchBarDelegate

extension MovieListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextChanged(text: searchText)
    }
}

// MARK: - UIScrollViewDelegate

extension MovieListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let needToFetchMoreMovies = scrollView.contentOffset.y > (scrollView.contentSize.height - tableView.frame.height)

        if needToFetchMoreMovies {
            viewModel.requestedMoreMovies()
        }
    }
}

// MARK: - Model

extension MovieListView {
    enum State {
        case hasData([SectionSource])
        case noData
    }
}

// MARK: - Appearance

private extension MovieListView {
    struct Appearance {
        let tableViewLeadingOffset: CGFloat = 18.0
        let tableViewTrailingInset: CGFloat = .gap_M
    }
}


