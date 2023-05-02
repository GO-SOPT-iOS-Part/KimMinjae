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

    func getStatusBarHeight() -> CGFloat {
        return self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 + 6
    }

    @discardableResult
    func setGradient(colors: [CGColor],
                     locations: [NSNumber] = [0.0, 1.0],
                     startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
                     endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) -> Self {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = self.bounds
        layer.addSublayer(gradient)
        return self
    }
}
