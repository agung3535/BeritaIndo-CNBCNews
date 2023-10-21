//
//  NewsServiceProtocol.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation


protocol NewsServiceProtocol: AnyObject {
    func getAllNews(completion: @escaping (Result<[CNBCNewsResource], APIError>) -> Void)
    func getNewsByCategory(category: String, completion: @escaping (Result<[CNBCNewsResource], APIError>) -> Void)
    func getCategoryCNBC(compeltion: @escaping (Result<[String], APIError>) -> Void)
}
