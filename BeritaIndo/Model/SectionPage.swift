//
//  SectionPage.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import Foundation

struct SectionPage {
    let id: UUID = UUID()
    let section: SectionType
}

enum SectionType {
    case category
    case newsList
}
