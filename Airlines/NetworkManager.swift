//
//  ApiManager.swift
//  Airlines
//
//  Created by Amruth Kallyam on 5/5/25.
//
 

import Foundation

enum ApiError: Error {
   case invalidUrl
   case invalidResponse
    case jsonParsingFailed(String)
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Request {
    var baseUrl: String { get set }
    var path: String { get set }
    var httpMethod: HttpMethod { get set }
    var params: [String: String]? { get set }
    var header: [String: String]? { get set }
}

extension Request {
    func createRequest()-> URLRequest? {
        var urlComponents =  URLComponents(string: baseUrl + path)
        if httpMethod == .get {
            urlComponents?.queryItems = params?.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        guard let url = urlComponents?.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = header
        
        if httpMethod == .post {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params ?? [:], options: [])
        }
        return urlRequest
    }
}

protocol Servicable {
    func excute<T>(request: any Request, modelName: T.Type) async throws-> T where T:Decodable
    
}


class NetworkManager: Servicable{
    func excute<T>(request: any Request, modelName: T.Type) async throws -> T where T:Decodable{
        guard let urlRequest = request.createRequest() else {
            throw ApiError.invalidUrl
        }
        let (data, _) = try await  URLSession.shared.data(for: urlRequest )
        return try JSONDecoder().decode(modelName.self, from: data)
    }
    
}

