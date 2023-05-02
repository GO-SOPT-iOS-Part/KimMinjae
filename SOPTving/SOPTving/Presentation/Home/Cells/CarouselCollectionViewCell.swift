//
//  CarouselCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        contentView.addSubviews(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureCarouselCell(poster: Poster) {
        posterImageView.image = poster.posterImage
//        posterImageView.setGradient(
//            colors: [UIColor.black.cgColor, UIColor.clear.cgColor],
//            locations: [0.1],
//            startPoint: .init(x: 0.5, y: 1),
//            endPoint: .init(x: 0.5, y: 0.8)
//        )
    }

}
