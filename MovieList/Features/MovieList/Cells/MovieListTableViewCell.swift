//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit
import SDWebImage

final class MovieListTableViewCell: UITableViewCell {
    private let appearence = Appearence()

    private lazy var movieTitleLabel = UILabel().with {
        $0.textColor = .white
        $0.font = .mlStandardHeavyFont
    }
    
    private lazy var movieImageView = UIImageView().with {
        $0.image = UIImage(named: "demo_image")
    }
    
    private lazy var movieGenreLabel = UILabel().with {
        $0.font = .mlSecondaryMediumFont
        $0.textColor = .mlGray
    }
    
    private lazy var movieMarkBar = UIProgressView().with {
        $0.backgroundColor = .mlGray2
        $0.tintColor = .mlTintColor
    }
    
    private lazy var movieMarkLabel = UILabel().with {
        $0.textColor = .mlGray
        $0.font = .mlSecondarySemiBoldFont
    }
    
    private lazy var separatorView = UIView().with {
        $0.backgroundColor = .mlGray3
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(model: MovieListTableViewCell.Model) {
        movieTitleLabel.text = model.title
        movieImageView.sd_setImage(with: model.imageUrl, placeholderImage: UIImage(named: "placeholder_movie_image"))
        movieGenreLabel.text = model.genre
        movieMarkBar.progress = model.markBarValue
        movieMarkLabel.text = model.mark
    }
}

private extension MovieListTableViewCell {
    func commonInit() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        backgroundColor = .mlDarkGray

        setupSubviews()
        setupConstarints()
    }

    func setupSubviews() {
        addSubview(movieTitleLabel)
        addSubview(movieImageView)
        addSubview(separatorView)
        addSubview(movieGenreLabel)
        addSubview(movieMarkBar)
        addSubview(movieMarkLabel)
    }

    func setupConstarints() {
        movieImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.height.equalTo(appearence.movieImageViewHeight)
            make.width.equalTo(appearence.movieImageViewWidth)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(appearence.movieTitleLabelTopOffset)
            make.trailing.equalTo(movieMarkLabel.snp.leading).offset(appearence.movieTitleLabelTrailingOffset)
            make.leading.equalTo(movieImageView.snp.trailing).offset(appearence.movieTitleLabelLeadingOffset)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(appearence.separatorViewHeight)
            make.trailing.leading.bottom.equalToSuperview()
        }
        
        movieGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(appearence.movieGenreLabelTopOffset)
            make.leading.equalTo(movieTitleLabel.snp.leading)
            make.trailing.equalTo(movieTitleLabel.snp.trailing)
        }
        
        movieMarkBar.snp.makeConstraints { make in
            make.height.equalTo(appearence.movieMarkBarHeight)
            make.leading.equalTo(movieGenreLabel.snp.leading)
            make.top.equalTo(movieGenreLabel.snp.bottom).offset(appearence.movieMarkBarTopOffset)
            make.width.equalToSuperview().multipliedBy(appearence.movieMarkBarWidthMultiplier)
        }
        
        movieMarkLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movieMarkBar.snp.centerY)
            make.leading.equalTo(movieMarkBar.snp.trailing).offset(appearence.movieMarkLabelLeadingOffset)
        }
    }
}

// MARK: - Appearance

private extension MovieListTableViewCell {
    struct Appearence {
        let movieImageViewHeight: CGFloat = 100.0
        let movieImageViewWidth: CGFloat = 65.0
        let movieTitleLabelTopOffset: CGFloat = 18.0
        let movieTitleLabelLeadingOffset: CGFloat = .gap_M
        let movieTitleLabelTrailingOffset: CGFloat = .gap_M
        let separatorViewHeight: CGFloat = 1.0
        let movieGenreLabelTopOffset: CGFloat = .gap_XS
        let movieMarkBarHeight: CGFloat = 5.0
        let movieMarkBarTopOffset: CGFloat = .gap_S
        let movieMarkBarWidthMultiplier: CGFloat = 0.6
        let movieMarkLabelLeadingOffset: CGFloat = .gap_XS
    }
}

// MARK: - Model

extension MovieListTableViewCell {
    struct Model {
        let title: String
        let imageUrl: URL?
        let genre: String
        let markBarValue: Float
        let mark: String
    }
}

// MARK: - TableViewAdaptableModelProtocol

extension MovieListTableViewCell.Model: TableViewAdaptableModelProtocol {
    func cell(at _: IndexPath, for tableView: UITableView) -> UITableViewCell {
        let cell: MovieListTableViewCell = tableView.dequeueReusableCell()
        cell.update(model: self)
        return cell
    }
}

