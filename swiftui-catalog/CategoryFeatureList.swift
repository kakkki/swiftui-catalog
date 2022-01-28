//
//  CategoryFeatureList.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import SwiftUI

struct CategoryFeatureList: View {
    let catalogCategories = [
        CatalogCategory(
            title: "Gesture Catalog",
            subtitle: "DragGesture, LongPressGesture etc...",
            text: "Using GestureState and updating method of the default Gesture Implementations and so on.",
            image: "Illustration 5",
            destinationView: AnyView(GestureCatalog())
        ),
        CatalogCategory(
            title: "Gesture Catalog",
            subtitle: "DragGesture, LongPressGesture etc...",
            text: "Using GestureState and updating method of the default Gesture Implementations and so on.",
            image: "Illustration 5",
            destinationView: AnyView(GestureCatalog())
        ),
        CatalogCategory(
            title: "Gesture Catalog",
            subtitle: "DragGesture, LongPressGesture etc...",
            text: "Using GestureState and updating method of the default Gesture Implementations and so on.",
            image: "Illustration 5",
            destinationView: AnyView(GestureCatalog())
        ),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(catalogCategories, id: \.self) { category in
                    CategoryFeature(catalogCategory: category)
                }
            }
        }
        // FIXME: 今はContentViewでNavigationViewを使っているので重複しないように隠してる
        .navigationBarHidden(true)
    }
}

struct CategoryFeatureList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFeatureList()
    }
}
