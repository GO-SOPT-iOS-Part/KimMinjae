//
//  MovieService.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/12.
//

import Foundation

import Alamofire

final class MovieService: BaseService {

    static let shared = MovieService()

    private init() {}

    func getPopularMovies<T: Decodable>(queryDTO: PopularMovieRequestDTO, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {

        let dataRequest = AF.request(MovieTarget.getPopularMovie(queryDTO))

        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value, type: T.self)
                completion(networkResult)
            case .failure:
                completion(.networkErr)
            }
        }

    }

}

//protocol MovieServiceProtocol {
//    func getPopularMovies<T: Decodable>(queryDTO: PopularMovieRequestDTO, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void)
//}
//
//extension MovieServiceProtocol {
//    func getPopularMovies<T: Decodable>(queryDTO: PopularMovieRequestDTO, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {
//
//        let dataRequest = AF.request(MovieTarget.getPopularMovie(queryDTO))
//
//        dataRequest.responseData { response in
//            switch response.result {
//            case .success:
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let value = response.value else { return }
//                let networkResult = self.judgeStatus(by: statusCode, value, type: T.self)
//                completion(networkResult)
//            case .failure:
//                completion(.networkErr)
//            }
//        }
//
//    }
//
//}
