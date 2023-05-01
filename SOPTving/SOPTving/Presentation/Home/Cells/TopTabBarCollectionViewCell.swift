//
//  TopTabBarCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class TopTabBarCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel().then {
        $0.font = .font(.pretendardRegular, ofSize: 17)
        $0.textColor = .tvingWhite
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureCell(title: String) {
        titleLabel.text = title
    }
    
}
