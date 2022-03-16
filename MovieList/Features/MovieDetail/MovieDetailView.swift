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
        $0.font = .mlHeaderFont
        $0.textColor = .white
        $0.text = NSLocalizedString("Overview", comment: "")
    }
    
    private lazy var overviewLabel = UILabel().with {
        $0.font = .mlStandardFont
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.textAlignment = .justified
    }
    
    private lazy var castHeaderLabel = UILabel().with {
        $0.font = .mlHeaderFont
        $0.textColor = .white
        $0.text = NSLocalizedString("Cast", comment: "")
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
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
        backgroundColor = appearance.backgroundColor
        
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
            make.height.equalTo(scrollView.snp.width).multipliedBy(appearance.posterImageViewHeightMultiplier)
        }
        
        overviewHeaderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(appearance.overviewHeaderLabelLeadingOffset)
            make.top.equalTo(posterImageView.snp.bottom).offset(appearance.overviewHeaderLabelTopOffset)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewHeaderLabel.snp.bottom).offset(appearance.overviewLabelTopOffset)
            make.leading.equalTo(overviewHeaderLabel.snp.leading)
            make.trailing.equalTo(posterImageView.snp.trailing).inset(appearance.overviewLabelTrailingInset)
        }
        
        castHeaderLabel.snp.makeConstraints { make in
            make.leading.equalTo(overviewHeaderLabel.snp.leading)
            make.top.equalTo(overviewLabel.snp.bottom).offset(appearance.castHeaderLabelTopOffset)
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
        let backgroundColor: UIColor = .black
        let posterImageViewHeightMultiplier: CGFloat = 1.45
        let overviewHeaderLabelLeadingOffset: CGFloat = .gap_M
        let overviewHeaderLabelTopOffset: CGFloat = .gap_M
        let overviewLabelTopOffset: CGFloat = .gap_XS
        let overviewLabelTrailingInset: CGFloat = .gap_M
        let castHeaderLabelTopOffset: CGFloat = .gap_M
    }
}

