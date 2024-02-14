//
//  SwiftUICatalogApp.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2021/12/29.
//

import SwiftUI

@main
struct SwiftUICatalogApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    CategoryFeatureList()
                        .navigationTitle("SwiftUICatalogApp")
                }
            } else {
                // Fallback on earlier versions
                CategoryFeatureList()
                    .navigationTitle("SwiftUICatalogApp")
            }
//            HomeRecommendedShopView()
        }
    }
}
