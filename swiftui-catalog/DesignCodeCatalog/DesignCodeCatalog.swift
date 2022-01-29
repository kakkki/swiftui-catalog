//
//  DesignCodeCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/29.
//

import SwiftUI

struct DesignCodeCatalog: View {

    var body: some View {
        List(designCodeSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }
    
    let designCodeSamples = [
        Sample(title: "FeaturedItem", desinationView: AnyView(FeaturedItem())),
        Sample(title: "TabbedFeaturedItems", desinationView: AnyView(TabbedFeaturedItems())),
        Sample(title: "Rotation3DEffectTab", desinationView: AnyView(Rotation3DEffectTab())),
    ]
}

struct DesignCodeCatalog_Previews: PreviewProvider {
    static var previews: some View {
        DesignCodeCatalog()
    }
}
