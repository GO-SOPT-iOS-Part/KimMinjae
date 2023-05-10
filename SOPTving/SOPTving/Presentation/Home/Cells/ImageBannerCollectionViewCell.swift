//
//  ImageBannerCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class ImageBannerCollectionViewCell: UICollectionViewCell {

    private let imageView = UIImageView().then {
        $0.image = ImageLiterals.Main.banner
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
