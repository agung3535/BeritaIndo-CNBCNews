//
//  NetworkManager.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 19/10/23.
//

import Foundation


class NetworkManager {
    private var baseURL = "https://berita-indo-api-next.vercel.app/api/"
    
    private init() {}
    
    static let shared = NetworkManager()
    
    private func createURLSessionUtility() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        
        let urlSession = URLSession.init(configuration: .default, delegate: nil, delegateQueue: queue)
        
        return urlSession
    }
    
    
    private func createRequestPath(urlPath: NewsApi,param: String) -> URLRequest? {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path.append(urlPath.rawValue + "/" + param)
        guard let url = urlComponent?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    private func createRequestQuery(urlPath: NewsApi,parameterQuery: [String: String] = [:]) -> URLRequest? {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path = urlPath.rawValue
        urlComponent?.queryItems = parameterQuery.map({ key, value in
            URLQueryItem(name: key, value: value)
        })
        guard let url = urlComponent?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    private func createRequest(urlPath: NewsApi) -> URLRequest? {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path.append(urlPath.rawValue)
        guard let url = urlComponent?.url  else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    private func handleDataTask(
        urlRequest: URLRequest,
        completion: @escaping(Result<Data?, APIError>) -> Void) -> URLSessionDataTask
    {
        let session = createURLSessionUtility()
        return session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.other(error)))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                switch response.statusCode {
                case 200:
                    completion(.success(data))
                    return
                case 401:
                    completion(.failure(.unauthorize))
                    return
                case 500:
                    completion(.failure(.internalServer))
                    return
                default:
                    completion(.failure(.unknownError("Whoops, check your code API code buddy !!")))
                    return
                }
            }
        }
    }
    
    func fetchData(urlPath: NewsApi,
                   parameterQuery: [String: String] = [:],
                   type: ParameterType = .none,
                   param: String = "",
                   completion: @escaping(Result<Data?, APIError>) -> Void
    ) {
        var urlRequest: URLRequest?
        switch type {
            
        case .path:
            urlRequest = createRequestPath(urlPath: urlPath, param: param)
        case .query:
            urlRequest = createRequestQuery(urlPath: urlPath, parameterQuery: parameterQuery)
        case .none:
            urlRequest = createRequest(urlPath: urlPath)
        }
    
        
        guard let validReq = urlRequest else {
            return
        }
        
        let task = handleDataTask(urlRequest: validReq, completion: completion)
        
        task.resume()
        
    }
    
}

enum APIError: Error {
    case invalidURL
    case decodeFailure
    case invalidResponse
    case unauthorize
    case netwokFailure
    case other(Error)
    case internalServer
    case unknownError(String)
}

enum ParameterType {
    case path
    case query
    case none
}

enum NewsApi: String {
    case cnbc = "cnbc-news"
    case all = ""
}
