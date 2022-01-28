//
//  LayoutEssenceCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import SwiftUI

struct LayoutEssenceCatalog: View {
    var body: some View {
        List(layoutSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }
    
    let layoutSamples = [
        Sample(title: "VStackSpacerLayoutSample", desinationView: AnyView(VStackSpacerLayoutSample())),
        Sample(title: "LayoutUsingSpacerSample", desinationView: AnyView(LayoutUsingSpacerSample())),
    ]
}

struct LayoutEssenceCatalog_Previews: PreviewProvider {
    static var previews: some View {
        LayoutEssenceCatalog()
    }
}
