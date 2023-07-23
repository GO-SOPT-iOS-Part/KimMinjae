//
//  MovieRepository.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/12.
//

import Foundation

protocol MovieRepository {
    func getPopularMovie(page: Int?, completion: @escaping (PopularMovieEntity?) -> Void)
}


final class DefaultMovieRespository {

    private let networkService: MovieService

    init(networkService: MovieService) {
        self.networkService = networkService
    }
}

extension DefaultMovieRespository: MovieRepository {

    func getPopularMovie(page: Int?,completion: @escaping (PopularMovieEntity?) -> Void) {
        let queryDTO = PopularMovieRequestDTO(
            apiKey: Config.apiKey,
            page: page,
            language: Language.english
        )

        networkService.getPopularMovies(queryDTO: queryDTO, type: PopularMovieEntity.self) { response in
            switch response {
            case .success(let entity):
                completion(entity)
            default:
                completion(nil)
            }
        }
    }

}
