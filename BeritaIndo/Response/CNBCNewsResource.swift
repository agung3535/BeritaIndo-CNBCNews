//
//  CNBCNewsResource.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation

struct CNBCNewsResource: Codable {
    let title: String
    let link: String
    let contentSnippet: String
    let isoDate: String
    let image: CNBCImage
    
    enum CodingKeys: String, CodingKey {
            case title, link, contentSnippet, isoDate, image
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "No Title Available"
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? "Not Available"
        contentSnippet = try container.decodeIfPresent(String.self, forKey: .contentSnippet) ?? "Not Available"
        isoDate = try container.decodeIfPresent(String.self, forKey: .isoDate) ?? "Not Available"
        image = try container.decodeIfPresent(CNBCImage.self, forKey: .image) ?? CNBCImage(from: decoder)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(link, forKey: .link)
        try container.encode(contentSnippet, forKey: .contentSnippet)
        try container.encode(isoDate, forKey: .isoDate)
        try container.encode(image, forKey: .image)
    }
}

struct CNBCImage: Codable {
    let small, large: String
    
    enum CodingKeys: String, CodingKey {
        case small,large
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
    }
    
}
