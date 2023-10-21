//
//  DataNews.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation

struct DataNews: Codable {
    let cnbcNews: CNBCNewsCategory
    
    enum CodingKeys: String, CodingKey {
        case cnbcNews = "CNBC News"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cnbcNews = try container.decodeIfPresent(CNBCNewsCategory.self, forKey: .cnbcNews) ?? CNBCNewsCategory(from: decoder)
    }
}
