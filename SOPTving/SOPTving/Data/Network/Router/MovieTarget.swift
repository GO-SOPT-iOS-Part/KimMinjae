//
//  MovieTarget.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/11.
//

import Foundation

import Alamofire

enum MovieTarget {
    case getPopularMovie(_ dto: PopularMovieRequestDTO)
}

extension MovieTarget: TargetType {

    var method: HTTPMethod {
        switch self {
        case .getPopularMovie:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPopularMovie(_):
            return "/popular"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .getPopularMovie(let dto):
            return .query(dto)
        }
    }

}
