//
//  PopularChannelCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class PopularChannelCollectionViewCell: UICollectionViewCell {
    private let thumbnailView = UIView().then {
        $0.backgroundColor = .blue
    }

    private let rankingLabel = UILabel().then {
        $0.font = .font(.pretendardBold, ofSize: 19)
        $0.textColor = .tvingWhite
        $0.transform = CGAffineTransform(rotationAngle: CGFloat(5 * Double.pi / 180))
    }

    private let channelNameLabel = UILabel().then {
        $0.font = .font(.pretendardRegular, ofSize: 10)
        $0.textColor = .tvingWhite
    }

    private let descriptionLabel = UILabel().then {
        $0.font = .font(.pretendardRegular, ofSize: 10)
        $0.textColor = .tvingGray2
    }

    private let ratingLabel = UILabel().then {
        $0.font = .font(.pretendardRegular, ofSize: 10)
        $0.textColor = .tvingGray2
    }

    private lazy var stackView = UIStackView(arrangedSubviews: [
        channelNameLabel,
        descriptionLabel,
        ratingLabel
    ]).then {
        $0.distribution = .equalSpacing
        $0.alignment = .leading
        $0.axis = .vertical
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        contentView.addSubviews(
            thumbnailView,
            rankingLabel,
            stackView
        )

        thumbnailView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(ScreenUtils.getHeight(80))
        }

        rankingLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailView.snp.bottom).offset(8)
            make.leading.equalTo(thumbnailView.snp.leading).offset(3)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(rankingLabel)
            make.leading.equalTo(rankingLabel.snp.trailing).offset(4)
//            make.bottom.equalToSuperview()
        }
    }

    func configureCell(rank: Int, channel: Channel) {
        rankingLabel.text = "\(rank)"
        channelNameLabel.text = channel.channelName
        descriptionLabel.text = channel.descriptionName
        ratingLabel.text = "\(channel.rating)%"
    }

}
