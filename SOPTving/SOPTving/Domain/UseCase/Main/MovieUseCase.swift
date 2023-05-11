//
//  MovieUseCase.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/12.
//

import Foundation

protocol MovieUseCase {
    func getPopularMovie(page: Int?, completion: @escaping ([Movie]?) -> Void)
}


final class DefaultMovieUseCase {

    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }
}

extension DefaultMovieUseCase: MovieUseCase {
    func getPopularMovie(page: Int?, completion: @escaping ([Movie]?) -> Void) {
        repository.getPopularMovie(page: page) { movieEntity in
            let movies = movieEntity?.toDomain()
            completion(movies)
        }
    }

}
