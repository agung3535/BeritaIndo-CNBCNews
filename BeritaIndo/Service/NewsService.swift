//
//  NewsService.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation

class NewsService: NewsServiceProtocol {
    
    weak var networkManager = NetworkManager.shared
    
    func getAllNews(completion: @escaping (Result<[CNBCNewsResource], APIError>) -> Void) {
        guard let networkManager = networkManager else {
            return
        }
        networkManager.fetchData(urlPath: .cnbc, type: .path) { data in
            switch data {
                
            case .success(let result):
                guard let result = result else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let resource = try JSONDecoder().decode(CNBCNewsResponse.self, from: result)
                    completion(.success(resource.data))
                }catch {
                    completion(.failure(.decodeFailure))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getNewsByCategory(category: String, completion: @escaping (Result<[CNBCNewsResource], APIError>) -> Void) {
        guard let networkManager = networkManager else {
            return
        }
        networkManager.fetchData(
            urlPath: .cnbc,
            type: .path,
            param: category
        ) { data in
            switch data {
                
            case .success(let result):
                guard let result = result else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let resource = try JSONDecoder().decode(CNBCNewsResponse.self, from: result)
                    completion(.success(resource.data))
                }catch {
                    completion(.failure(.decodeFailure))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCategoryCNBC(compeltion: @escaping (Result<[String], APIError>) -> Void) {
        guard let networkManager = networkManager else {
            return
        }
        networkManager.fetchData(urlPath: .all) { data in
            switch data {
            case .success(let success):
                
                guard let result = success else {
                    compeltion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let resource = try JSONDecoder().decode(AllNewsResponse.self, from: result)
                    compeltion(.success(resource.data.cnbcNews.listType))
                }catch {
                    compeltion(.failure(.decodeFailure))
                }
            case .failure(let failure):
                compeltion(.failure(failure))
            }
        }
    }
    
    
}
