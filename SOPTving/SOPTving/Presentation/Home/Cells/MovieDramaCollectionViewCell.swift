//
//  MovieDramaCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/29.
//

import UIKit

final class MovieDramaCollectionViewCell: UICollectionViewCell {
    private let posterImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }

    private let titleLabel = UILabel().then {
        $0.contentMode = .scaleAspectFit
        $0.textColor = .tvingGray2
        $0.font = .font(.pretendardMedium, ofSize: 10)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        self.posterImageView.image = nil
    }

    private func setStyle() {
        contentView.backgroundColor = .tvingBlack
    }

    private func setLayout() {
        contentView.addSubviews(posterImageView, titleLabel)

        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(ScreenUtils.getHeight(146))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(posterImageView)
            make.top.equalTo(posterImageView.snp.bottom).offset(3)
        }
    }

    func configureCell(movie: Movie) {
        movie.posterImagePath.downloadImageWithURLString(completion: { image in
            self.posterImageView.image = image
        })
        titleLabel.text = movie.title
    }

}
