//
//  TargetType.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/11.
//

import Foundation

import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

extension TargetType {
    var baseURL: String {
        return Config.baseURL
    }
}


extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(
            url: url.appendingPathComponent(path),
            method: method
        )

        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        switch parameters {
        case .body(let request):
            let params = request?.toDictionary() ?? [:]

            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        case .query(let request):
            let params = request?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .requestPlain:
            break
        }
        return urlRequest
    }
}

enum RequestParams {
    case requestPlain
    case query(_ parameter: Encodable?)
    case body(_ paramter: Encodable?)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any]
        else { return [:] }

        return dictionaryData
    }
}
