//
//  CatalogCategory.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import Foundation
import SwiftUI

struct CatalogCategory: Identifiable, Hashable {

    let id = UUID()
    let title: String
    let subtitle: String
    let text: String
    let image: String
    let destinationView: AnyView

    static func == (lhs: CatalogCategory, rhs: CatalogCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
