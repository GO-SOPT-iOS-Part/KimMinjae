//
//  ProfileTableViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/24.
//

import UIKit

final class ProfileHeaderView: BaseView {

    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .tvingWhite
        $0.makeRounded(cornerRadius: 15)
        $0.image = ImageLiterals.MyPage.dusan
    }

    private let profileName = UILabel().then {
        $0.text = "Doosan"
        $0.font = .font(.pretendardMedium, ofSize: 17)
        $0.textColor = .tvingWhite
    }

    private let profileButton = TvingButton(type: .changeProfile).then {
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 11, bottom: 5, right: 11)
    }

    private let membershipView = MembershipView()

    private let labelButtonView = LabelButtonView()

    override func setLayout() {
        self.backgroundColor = .tvingBlack
        self.addSubviews(
            profileImageView,
            profileName,
            profileButton,
            membershipView,
            labelButtonView
        )

        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(74)
            make.top.equalToSuperview().inset(35)
            make.leading.equalToSuperview().inset(24)
        }

        profileName.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(22)
        }

        profileButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileName)
            make.trailing.equalToSuperview().inset(23)
        }

        membershipView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(29)
            make.leading.trailing.equalToSuperview().inset(10)
        }

        labelButtonView.snp.makeConstraints { make in
            make.top.equalTo(membershipView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(membershipView)
            make.bottom.equalToSuperview().inset(24)
        }
    }

}
