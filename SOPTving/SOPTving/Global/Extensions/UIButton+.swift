//
//  UIButton+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/15.
//

import UIKit

extension UIButton {
    // Button Configuration 쓰면 이거 안먹음. AttributedString으로 대체가능
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
