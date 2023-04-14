//
//  UIView+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/14.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    /// UIView 의 모서리가 둥근 정도를 설정하는 메서드
    func makeRounded(cornerRadius: CGFloat?) {
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        } else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }

        self.clipsToBounds = true
//        self.layer.masksToBounds = false
    }
}
