//
//  Const.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/03.
//

import UIKit


enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

enum TMDBImageURL {
    static let posterURL = "https://image.tmdb.org/t/p/original"
}

enum Headers {
    static let empty = ""
    static let mustsee = "티빙에서 꼭 봐야하는 컨텐츠"
    static let popularLiveChannel = "인기 LIVE 채널"
    static let paramount = "파라마운트+의 따끈한 신작"
    static let recommend = "김민재님이 좋아할만한 영화"
    static let animation = "놓칠 수 없는 티빙 명작 애니메이션"
    static let collection = "황금연휴를 책임져 줄 프로그램 컬렉션"
}
