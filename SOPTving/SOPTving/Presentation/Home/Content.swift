//
//  Contents.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/29.
//

import UIKit


struct Content {
    let image: UIImage
    let title: String
}

struct Channel {
    let channelName: String
    let descriptionName: String
    let rating: Float
}


extension Content {
    static func dummy() -> [Content] {
        return [
            Content(image: ImageLiterals.Main.harryPoter, title: "해리포터"),
            Content(image: ImageLiterals.Main.signalMovie, title: "시그널"),
            Content(image: ImageLiterals.Main.ring, title: "반지의 제왕"),
            Content(image: ImageLiterals.Main.yourName, title: "너의 이름은"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.harryPoter, title: "해리포터"),
            Content(image: ImageLiterals.Main.harryPoter, title: "해리포터"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.harryPoter, title: "해리포터"),
            Content(image: ImageLiterals.Main.signalMovie, title: "시그널"),
            Content(image: ImageLiterals.Main.ring, title: "반지의 제왕"),
            Content(image: ImageLiterals.Main.yourName, title: "너의 이름은"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.harryPoter, title: "해리포터"),
            Content(image: ImageLiterals.Main.harryPoter, title: "해리포터"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속"),
            Content(image: ImageLiterals.Main.suzume, title: "스즈메의 문단속")
        ]
    }
}

extension Channel {
    static func dummy() -> [Channel] {
        var arr: [Channel] = []
        for _ in 0..<20 {
            arr.append(
                Channel(channelName: "tvN", descriptionName: "부산 촌놈", rating: 16.4)
            )
        }
        return arr
    }
}
