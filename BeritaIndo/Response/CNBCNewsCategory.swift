//
//  CNBCNewsCategory.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation


struct CNBCNewsCategory: Codable {
    let listType: [String]
    
    enum CodingKeys: String, CodingKey{
        case listType
    }
    
    init(listType: [String]) {
        self.listType = listType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.listType = try container.decodeIfPresent([String].self, forKey: .listType) ?? []
    }
}
