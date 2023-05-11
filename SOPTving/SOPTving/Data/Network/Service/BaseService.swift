//
//  BaseService.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/11.
//

import Foundation

import Alamofire


class BaseService {

    static let shared = BaseService()
    private init() {}

    func requestObject<T: Decodable>(_ target: TargetType, completion: @escaping (NetworkResult<T>) -> Void) {
        let dataRequest = AF.request(target)
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

    private func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<T> {
        switch statusCode {
        case 200: return isValidData(data: data, type: T.self)
        case 401...409: return isValidData(data: data, type: T.self)
        case 500: return .serverErr
        default: return .networkErr
        }
    }

    private func isValidData<T: Decodable>(data: Data, type: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("json decoded failed !")
            return .pathErr
        }

        return .success(decodedData)
    }

}
