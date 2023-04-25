//
//  MembershipView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

final class MembershipView: BaseView {

    private let membershipImageView = UIImageView().then {
        $0.image = ImageLiterals.MyPage.membership.withRenderingMode(.alwaysOriginal)
    }

    private let membershipLabel = UILabel().then {
        $0.font = .font(.pretendardMedium, ofSize: 13)
        $0.textColor = .tvingGray3
        $0.text = "나의 이용권"
    }

    private lazy var membershipStackView = UIStackView(arrangedSubviews: [
        membershipImageView,
        membershipLabel
    ]).then {
        $0.spacing = 5
    }

    private let currentMembershipLabel = UILabel().then {
        $0.font = .font(.pretendardMedium, ofSize: 13)
        $0.textColor = .tvingGray3
        $0.text = "사용중인 이용권이 없습니다"
    }

    private let cashImageView = UIImageView().then { 
        $0.image = ImageLiterals.MyPage.cash.withRenderingMode(.alwaysOriginal)
    }

    private lazy var cashStackView =
    UIStackView(arrangedSubviews: [
        cashImageView,
        cashLabel
    ]).then {
        $0.spacing = 5
    }

    private let cashLabel = UILabel().then {
        $0.font = .font(.pretendardMedium, ofSize: 13)
        $0.textColor = .tvingGray3
        $0.text = "티빙캐시"
    }

    private let currentCashLabel = UILabel().then {
        $0.font = .font(.pretendardBold, ofSize: 15)
        $0.textColor = .tvingWhite
        $0.text = "0"
    }

    override func setStyle() {
        self.backgroundColor = .tvingGray5
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }

    override func setLayout() {
        self.addSubviews(
            membershipStackView,
            currentMembershipLabel,
            cashStackView,
            currentCashLabel
        )

        membershipStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(11)
        }

        currentMembershipLabel.snp.makeConstraints { make in
            make.centerY.equalTo(membershipStackView)
            make.trailing.equalToSuperview().inset(13)
        }

        cashStackView.snp.makeConstraints { make in
            make.top.equalTo(membershipStackView.snp.bottom).offset(17)
            make.leading.equalTo(membershipStackView)
            make.bottom.equalToSuperview().inset(16)
        }

        currentCashLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cashStackView)
            make.trailing.equalTo(currentMembershipLabel)
        }
    }
}
