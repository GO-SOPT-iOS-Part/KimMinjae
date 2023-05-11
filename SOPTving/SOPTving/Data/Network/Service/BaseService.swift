//
//  BaseService.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/11.
//

import Foundation

import Alamofire

protocol BaseService {
    func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<T>
    func isValidData<T: Decodable>(data: Data, type: T.Type) -> NetworkResult<T>
}

extension BaseService {
    func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<T> {
        switch statusCode {
        case 201: return isValidData(data: data, type: T.self)
        case 400, 409: return isValidData(data: data, type: T.self)
        case 500: return .serverErr
        default: return .networkErr
        }
    }

    func isValidData<T: Decodable>(data: Data, type: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("json decoded failed !")
            return .pathErr
        }

        return .success(decodedData)
    }

}
