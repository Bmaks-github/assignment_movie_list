//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit
import SDWebImage

final class MovieDetailView: UIView {
    private let appearance = Appearance()
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var posterImageView = UIImageView()
    
    private lazy var overviewHeaderLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .white
        $0.text = "Overview"
    }
    
    private lazy var overviewLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.textAlignment = .justified
    }
    
    private lazy var castHeaderLabel = UILabel().with {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .white
        $0.text = "Cast"
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        posterImageView.sd_setImage(with: model.posterImageUrl, placeholderImage: UIImage(named: "placeholder_movie_image"))
        overviewLabel.text = model.overviewText
    }
}

// MARK: - Private methods

private extension MovieDetailView {
    func commonInit() {
        backgroundColor = .black
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        scrollView.addSubview(castHeaderLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(overviewHeaderLabel)
        scrollView.addSubview(posterImageView)
        
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(snp.trailing)
            make.height.equalTo(scrollView.snp.width).multipliedBy(1.45)
        }
        
        overviewHeaderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewHeaderLabel.snp.bottom).offset(8)
            make.leading.equalTo(overviewHeaderLabel.snp.leading)
            make.trailing.equalTo(posterImageView.snp.trailing).inset(16)
        }
        
        castHeaderLabel.snp.makeConstraints { make in
            make.leading.equalTo(overviewHeaderLabel.snp.leading)
            make.top.equalTo(overviewLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Model
extension MovieDetailView {
    struct Model {
        let posterImageUrl: URL?
        let overviewText: String
    }
}

// MARK: - Appearance
private extension MovieDetailView {
    struct Appearance {
        
    }
}

