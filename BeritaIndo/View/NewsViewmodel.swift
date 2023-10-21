//
//  NewsViewmodel.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 21/10/23.
//

import Foundation


class NewsViewmodel {
    
    var newsListUpdate: (() -> Void)?
    var categoryList: (() -> Void)?
    var errorAppear: ((APIError) -> Void)?
    var errorCategory: ((APIError) -> Void)?
    var newsLoading: ((Bool) -> Void)?
    var categoryLoad: ((Bool) -> Void)?
    
    var service: NewsServiceProtocol
    
    init(service: NewsServiceProtocol) {
        self.service = service
    }
    
    private(set) var news: [CNBCNewsResource] = [] {
        didSet {
            self.newsListUpdate?()
        }
    }
    
    private(set) var category: [String] = [] {
        didSet {
            self.categoryList?()
        }
    }
    
    
    func getNews() {
        self.newsLoading?(true)
        service.getAllNews(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.news = news
                self.newsLoading?(false)
            case .failure(let failure):
                self.errorAppear?(failure)
                self.newsLoading?(false)
            }
        })
    }
    
    func getNewsByCategory(data: String) {
        self.news.removeAll()
        service.getNewsByCategory(category: data, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.news = news
            case .failure(let failure):
                self.errorAppear?(failure)
            }
        })
    }
    
    func getNewsCategory() {
        service.getCategoryCNBC { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.category = success
                self.category.insert("all", at: 0)
            case .failure(let failure):
                self.errorCategory?(failure)
            }
        }
    }
    
}
