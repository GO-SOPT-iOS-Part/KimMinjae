//
//  PopularMovieRequestDTO.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/12.
//

import Foundation

struct PopularMovieRequestDTO: Encodable {
    let apiKey: String
    let page: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case page, language
    }
}

enum Language {
    static let english = "en-US"
}
