//
//  TabbedFeaturedItems.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/08.
//

import SwiftUI

struct TabbedFeaturedItems: View {
    var body: some View {
        TabView {
            ForEach(sampleCourses) { course in
                FeaturedItem(course: course)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 460)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
    }
}

struct TabbedFeaturedItems_Previews: PreviewProvider {
    static var previews: some View {
        TabbedFeaturedItems()
    }
}
