//
//  CategoryFeature.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import SwiftUI

struct CategoryFeature: View {

    var catalogCategory: CatalogCategory = sampleCatalogCategories[0]

    var body: some View {
        NavigationLink(destination: catalogCategory.destinationView) {
            VStack(alignment: .leading, spacing: 8.0) {
                Spacer()
                Text(catalogCategory.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .lineLimit(1)
                Text(catalogCategory.subtitle)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                Text(catalogCategory.text)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            .shadow(color: Color("Shadow").opacity(0.3),
                    radius: 20, x: 0, y: 30)
            .padding(20)
            .overlay(
                Image(catalogCategory.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: 40, y: -80)
                    .frame(height: 230)
            )
        }
    }
}

let sampleCatalogCategories = [
    CatalogCategory(
        title: "Gesture Catalog",
        subtitle: "DragGesture, LongPressGesture etc...",
        text: "Using GestureState and updating method of the default Gesture Implementations and so on.",
        image: "DragAndGesture",
        destinationView: AnyView(GestureCatalog())
    )
]

struct CategoryFeature_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFeature()
    }
}
