//
//  MainHomeViewModel.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import Foundation


final class MainHomeViewModel {
    let headerText: [String] = [
        "티빙에서 꼭 봐야하는 컨텐츠",
        "인기 LIVE 채널",
        "인기 LIVE 채널",
        "인기 LIVE 채널",
        "인기 LIVE 채널",
        "인기 LIVE 채널",
        "인기 LIVE 채널"
    ]

    let contentDummy = Content.dummy()
    let channelDummy = Channel.dummy()
    var posterCarouselImages: [Poster] = Poster.dummy()
}
