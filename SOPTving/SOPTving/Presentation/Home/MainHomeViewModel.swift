//
//  MainHomeViewModel.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import Foundation


final class MainHomeViewModel {
    let headerText: [String] = [
        "",
        "인기 LIVE 채널",
        "티빙에서 꼭 봐야하는 컨텐츠",
        "",
        "파라마운트+의 따끈한 신작",
        "김민재님이 좋아할만한 영화",
        "황금연휴를 책임져 줄 프로그램 컬렉션",
        "놓칠 수 없는 티빙 명작 애니메이션"
    ]

    let contentDummy = Content.dummy()
    let channelDummy = Channel.dummy()
    var posterCarouselImages: [Poster] = Poster.dummy()
}
