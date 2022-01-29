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
            image: "DragAndGesture",
            destinationView: AnyView(GestureCatalog())
        ),
        CatalogCategory(
            title: "Carousel Catalog",
            subtitle: "Not TabView but Carousel...",
            text: "Using DragGesture, LazyHStack, offset etc...",
            image: "Carousel",
            destinationView: AnyView(CarouselCatalog())
        ),
        CatalogCategory(
            title: "Decoration Catalog",
            subtitle: "DashedLine etc...",
            text: "Using Path and Stroke etc....",
            image: "Decoration",
            destinationView: AnyView(DecorationCatalog())
        ),
        CatalogCategory(
            title: "GeometryReader Catalog",
            subtitle: "In SwiftUI, you have to use GeometryReader...",
            text: "Using GeometryReader and Preferences etc....",
            image: "GeometryReader",
            destinationView: AnyView(GeometryReaderCatalog())
        ),
        CatalogCategory(
            title: "LayoutEssence Catalog",
            subtitle: "How to layout detail in SwiftUI",
            text: "Using Spacer etc....",
            image: "Layout",
            destinationView: AnyView(LayoutEssenceCatalog())
        ),
        CatalogCategory(
            title: "DesignCode Catalog",
            subtitle: "designcode.io examples",
            text: "GeometryReader, TrackableScrollView, etc...",
            image: "Illustration 5",
            destinationView: AnyView(DesignCodeCatalog())
        ),
        CatalogCategory(
            title: "StackCard Catalog",
            subtitle: "Stack Cards examples",
            text: "offset, rotation3DEffect, etc...",
            image: "StackCards",
            destinationView: AnyView(DesignCodeCatalog())
        ),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    ForEach(catalogCategories, id: \.self) { category in
                        CategoryFeature(catalogCategory: category)
                    }
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CategoryFeatureList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFeatureList()
    }
}
