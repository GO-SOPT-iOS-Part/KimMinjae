//
//  TvingButton.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

final class TvingButton: UIButton {

    @frozen
    enum ButtonType {
        case changeProfile
        case logout
        case seeAll

        var textColor: UIColor {
            switch self {
            case .changeProfile:
                return .tvingGray1
            case .logout:
                return .tvingGray2
            case .seeAll:
                return .tvingGray3
            }
        }

        var text: String {
            switch self {
            case .changeProfile:
                return "프로필 전환"
            case .seeAll:
                return "전체보기"
            case .logout:
                return "로그아웃"
            }
        }

        var borderColor: UIColor {
            switch self {
            case .changeProfile, .logout:
                return .tvingGray4
            case .seeAll:
                return .clear
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .changeProfile, .logout:
                return 2
            case .seeAll:
                return .zero
            }
        }

        var textSize: CGFloat {
            switch self {
            case .changeProfile, .seeAll:
                return 10
            case .logout:
                return 14
            }
        }
    }

    private var tvingButtonType: ButtonType

    init(type: ButtonType) {
        self.tvingButtonType = type
        super.init(frame: .zero)
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI & Layout

    private func setStyle() {
        self.backgroundColor = .tvingBlack
        self.layer.borderColor = tvingButtonType.borderColor.cgColor
        self.layer.cornerRadius = tvingButtonType.cornerRadius
        self.layer.borderWidth = 1
        self.clipsToBounds = true

        self.setTitle(tvingButtonType.text, for: .normal)
        self.setTitleColor(tvingButtonType.textColor, for: .normal)
        self.titleLabel?.font = .font(.pretendardMedium, ofSize: tvingButtonType.textSize)
    }

    private func setLayout() {
        if tvingButtonType == .seeAll {
            var config = UIButton.Configuration.plain()
            config.image = ImageLiterals.MyPage.nextArrow
            config.imagePadding = 1
            self.configuration = config
        }
    }



}
