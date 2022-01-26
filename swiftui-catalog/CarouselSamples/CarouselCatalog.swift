//
//  CarouselCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct CarouselCatalog: View {
    var body: some View {
        NavigationView {
            List(carouselSamples) { sample in
                NavigationLink(sample.title, destination: sample.desinationView)
            }
        }
    }

    let carouselSamples = [
        Sample(title: "✨⭐️Sample Components⭐️✨ -----", desinationView: nil),
    ]
}
    
struct CarouselCatalog_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCatalog()
    }
}
