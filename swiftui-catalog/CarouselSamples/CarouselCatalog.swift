//
//  CarouselCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct CarouselCatalog: View {
    
    var body: some View {
        // @see https://stackoverflow.com/questions/58065081/swiftui-double-navigation-bar
        // ContentViewですでにNavigationViewの中にCarouselCatalogがある
        // なのでCarouselCatalogの中でNavigationViewを使うと二重になってしまう
        List(carouselSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let carouselSamples = [
        Sample(title: "-----RectangleCarousel -----", desinationView: AnyView(RectangleCarousel())),
    ]
}
    
struct CarouselCatalog_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCatalog()
    }
}
