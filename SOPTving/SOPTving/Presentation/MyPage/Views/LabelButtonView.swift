//
//  LabelButtonView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

final class LabelButtonView: BaseView {

    private let label = UILabel().then {
        var titleAttr = NSMutableAttributedString(string: "이용권을 구매하고 ")
        let tvnImage = NSTextAttachment(image: ImageLiterals.MyPage.tvnLogo)
        let jtbclogo = ImageLiterals.MyPage.jtbcLogo.resize(to: CGSize(width: 30, height: 16))
        let jtbcImage = NSTextAttachment(image: jtbclogo)
        titleAttr.append(NSAttributedString(attachment: tvnImage))
        titleAttr.append(NSAttributedString(attachment: jtbcImage))
        var titleAttr2 = NSMutableAttributedString(string: " 등 인기 TV프로그램과\n다양한 영화 콘텐츠를 자유롭게 시청하세요!")
        titleAttr.append(titleAttr2)

        titleAttr.addAttribute(
            .font,
            value: UIFont.font(.pretendardSemiBold, ofSize: 12),
            range: NSRange(location: 0, length: titleAttr.length)
        )
        titleAttr.addAttribute(
            .foregroundColor,
            value: UIColor.tvingGray2,
            range: NSRange(location: 0, length: titleAttr.length)
        )

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 7
        titleAttr.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: titleAttr.length)
        )
        
        $0.attributedText = titleAttr
        $0.numberOfLines = 2
    }

    private let nextArrow = UIImageView().then {
        $0.image = ImageLiterals.MyPage.nextArrow
    }

    override func setStyle() {
        self.backgroundColor = .tvingGray5
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }

    override func setLayout() {
        self.addSubviews(
            label,
            nextArrow
        )

        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(18)
        }

        nextArrow.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.trailing.equalToSuperview().inset(13)
            make.size.equalTo(18)
        }
    }
}
