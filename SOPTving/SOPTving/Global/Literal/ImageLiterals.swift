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
