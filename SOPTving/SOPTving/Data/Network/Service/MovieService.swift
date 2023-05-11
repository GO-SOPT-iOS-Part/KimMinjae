//
//  MovieService.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/12.
//

import Foundation

import Alamofire


protocol MovieService {
    func getPopularMovies<T: Decodable>(queryDTO: PopularMovieRequestDTO, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void)
}

extension BaseService: MovieService {
    func getPopularMovies<T: Decodable>(queryDTO: PopularMovieRequestDTO, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {
        requestObject(MovieTarget.getPopularMovie(queryDTO), completion: completion)
    }
}
