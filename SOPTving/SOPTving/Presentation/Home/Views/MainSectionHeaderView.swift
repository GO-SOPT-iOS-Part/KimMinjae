//
//  MainSectionHeaderView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/29.
//

import UIKit

class MainSectionHeaderView: UICollectionReusableView {

    private let descriptionLabel = UILabel().then {
        $0.textColor = .tvingWhite
        $0.font = .font(.pretendardSemiBold, ofSize: 15)
    }

    private let seeAllButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString("전체보기")
        titleAttr.font = .font(.pretendardMedium, ofSize: 13)
        config.attributedTitle = titleAttr
        config.baseForegroundColor = .tvingGray2
        config.image = ImageLiterals.MyPage.nextArrow
            .withTintColor(.tvingGray2, renderingMode: .alwaysTemplate)
            .resize(to: CGSize(width: 10, height: 10))
        config.imagePlacement = .trailing
        config.imagePadding = 0
        let button = UIButton(configuration: config)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubviews(descriptionLabel, seeAllButton)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(descriptionLabel)
            make.trailing.equalToSuperview()
        }
    }

    func configHeaderView(text: String) {
        descriptionLabel.text = text
    }

}
