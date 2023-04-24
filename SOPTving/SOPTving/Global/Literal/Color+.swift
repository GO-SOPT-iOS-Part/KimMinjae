//
//  Color+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/13.
//
import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: 1
        )
    }
}

extension UIColor {

    @nonobjc class var tvingRed: UIColor {
        return UIColor(r: 255, g: 20, b: 60)
    }

    @nonobjc class var tvingBlack: UIColor {
        return UIColor(r: 0, g: 0, b: 0)
    }

    @nonobjc class var tvingWhite: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }

    @nonobjc class var tvingGray1: UIColor {
        return UIColor(r: 214, g: 214, b: 214)
    }

    @nonobjc class var tvingGray2: UIColor {
        return UIColor(r: 156, g: 156, b: 156)
    }

    @nonobjc class var tvingGray3: UIColor {
        return UIColor(r: 98, g: 98, b: 98)
    }

    @nonobjc class var tvingGray4: UIColor {
        return UIColor(r: 46, g: 46, b: 46)
    }

}
