//
//  ImageLiteral.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/13.
//

import UIKit

struct ImageLiterals {

    struct Auth {
        static var eye: UIImage { .load(named: "eye") }
        static var eyeSlash: UIImage { .load(named: "eye_slash") }
        static var buttonBefore: UIImage { .load(named: "btn_before") }
        static var xCircle: UIImage { .load(named: "x_circle") }
        static var tvingLogo: UIImage { .load(named: "tving_logo") }
    }

    struct MyPage {
        static var dusan: UIImage { .load(named: "dusan") }
        static var membership: UIImage { .load(named: "membership") }
        static var cash: UIImage { .load(named: "cash") }
        static var alarm: UIImage { .load(named: "alarm") }
        static var alarm2: UIImage { .load(named: "alarm2") }
        static var jtbcLogo: UIImage { .load(named: "jtbcLogo") }
        static var tvnLogo: UIImage { .load(named: "tvnLogo") }
        static var setting: UIImage { .load(named: "setting") }
        static var setting2: UIImage { .load(named: "setting2") }
        static var nextArrow: UIImage { .load(named: "nextArrow") }
    }

    struct Main {
        static var tvingWhiteLogo: UIImage { .load(named: "tving_white_logo") }
        static var harryPoter: UIImage { .load(named: "harrypoter") }
        static var ring: UIImage { .load(named: "ring") }
        static var signalMovie: UIImage { .load(named: "signalMovie") }
        static var suzume: UIImage { .load(named: "suzume") }
        static var yourName: UIImage { .load(named: "yourName") }
        static var banner: UIImage { .load(named: "banner") }
        static var baseball: UIImage { .load(named: "baseball") }
        static var demonSlayer: UIImage { .load(named: "demonSlayer") }
    }
}


extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }

    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
