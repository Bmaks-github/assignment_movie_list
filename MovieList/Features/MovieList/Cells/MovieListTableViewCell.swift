//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit
import SDWebImage

public final class MovieListTableViewCell: UITableViewCell {
    private let appearence = Appearence()

    private lazy var movieTitleLabel = UILabel().with {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 17, weight: .heavy)
    }
    
    private lazy var movieImageView = UIImageView().with {
        $0.image = UIImage(named: "demo_image")
    }
    
    private lazy var movieGenreLabel = UILabel().with {
        $0.text = "Fantasy, Actions, Sci-Fi".uppercased()
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = UIColor(red: 134.0/256.0, green: 134.0/256.0, blue: 135.0/256.0, alpha: 1)
    }
    
    private lazy var movieMarkBar = UIProgressView().with {
        $0.backgroundColor = UIColor(red: 61.0/256.0, green: 61.0/256.0, blue: 65.0/256.0, alpha: 1)
        $0.tintColor = UIColor(red: 255.0/256.0, green: 152.0/256.0, blue: 0, alpha: 1)
        $0.progress = 0.5
    }
    
    private lazy var movieMarkLabel = UILabel().with {
        $0.textColor = UIColor(red: 134.0/256.0, green: 134.0/256.0, blue: 135.0/256.0, alpha: 1)
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.text = "5.5"
    }

//
//    private lazy var signerNameLabel: UILabel = .make {
//        $0.style = TextStyle.secondaryText.set(color: .abm_darkIndigo60)
//        $0.numberOfLines = appearence.signerNameLabelNumberOfLines
//    }
//
//    private lazy var separatorView: UIView = .make {
//        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
//    }
    
    private lazy var separatorView = UIView().with {
        $0.backgroundColor = UIColor(red: 35.0/256.0, green: 35.0/256.0, blue: 38.0/256.0, alpha: 1)
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
        backgroundColor = UIColor(red: 28.0/256.0, green: 28.0/256.0, blue: 30.0/256.0, alpha: 1)

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
            make.height.equalTo(100)
            make.width.equalTo(65)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalTo(movieMarkLabel.snp.leading).offset(16)
            make.leading.equalTo(movieImageView.snp.trailing).offset(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.bottom.equalToSuperview()
        }
        
        movieGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(movieTitleLabel.snp.leading)
        }
        
        movieMarkBar.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.leading.equalTo(movieGenreLabel.snp.leading)
            make.top.equalTo(movieGenreLabel.snp.bottom).offset(12)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        movieMarkLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movieMarkBar.snp.centerY)
            make.leading.equalTo(movieMarkBar.snp.trailing).offset(8)
        }
    }
}

// MARK: - Appearance

private extension MovieListTableViewCell {
    struct Appearence {

    }
}

// MARK: - Model

public extension MovieListTableViewCell {
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
    public func cell(at _: IndexPath, for tableView: UITableView) -> UITableViewCell {
        let cell: MovieListTableViewCell = tableView.dequeueReusableCell()
        cell.update(model: self)
        return cell
    }
}

