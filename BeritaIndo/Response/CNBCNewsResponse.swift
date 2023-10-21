//
//  CNBCNewsResponse.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation


struct CNBCNewsResponse: Codable {
    let message: String
    let total: Int
    let data: [CNBCNewsResource]
    
    enum CodingKeys: String, CodingKey {
        case message, total, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? "no message"
        total = try container.decodeIfPresent(Int.self, forKey: .total) ?? 0
        data = try container.decodeIfPresent([CNBCNewsResource].self, forKey: .data) ?? []
    }
}

