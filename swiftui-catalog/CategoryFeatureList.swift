//
//  CategoryFeatureList.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import SwiftUI

/** next todo

 GridViewを試す
 
    1. FirstViewをContentViewではなく、このCategoryFeatureListにする
        ContentViewの中身をcatalogCategoriesに移植する
 
    2. 各CatalogはGridViewで各画面への導線を実装する
 
*/

/* それぞれのイメージに合うように、画像も探してAssetに登録しないと
 Gesture:
 
 Carousel:
 
 GeometryReader:
 
 Decoration:
    DashedLine
    
 Layout Essence:
    LayoutUsingSpacer
    VStackSpacerLayoutSample
    OverlayViewSample
 
 未分類:
    EditableListSample
 
 */

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
