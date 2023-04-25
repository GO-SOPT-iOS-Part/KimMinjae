//
//  MyPageTableViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/24.
//

import UIKit

final class MyPageTableViewCell: UITableViewCell {

    private let titleLabel = UILabel().then {
        $0.font = .font(.pretendardMedium, ofSize: 15)
        $0.textColor = .tvingGray2
    }

    private let nextArrowButton = UIButton().then {
        $0.setImage(
            ImageLiterals.MyPage.nextArrow.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setLayout() {
        contentView.backgroundColor = .tvingBlack
        contentView.addSubviews(titleLabel, nextArrowButton)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(18)
        }

        nextArrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(18)
            make.size.equalTo(18)
        }
    }

    func configCell(title: String) {
        self.titleLabel.text = title
    }

}
