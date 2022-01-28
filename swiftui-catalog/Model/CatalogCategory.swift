//
//  CatalogCategory.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import Foundation

struct CatalogCategory: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let text: String
    let image: String
}
