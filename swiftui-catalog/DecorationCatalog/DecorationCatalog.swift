//
//  DecorationCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import SwiftUI

struct DecorationCatalog: View {
    var body: some View {
        List(decorationSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let decorationSamples = [
        Sample(title: "DashedLineSample", desinationView: AnyView(DashedLineSample())),
        Sample(title: "OverlayViewSample", desinationView: AnyView(OverlayViewSample())),
        Sample(title: "EditableListSample", desinationView: AnyView(EditableListSample())),
        Sample(title: "Replace Animation API from iOS15", desinationView: AnyView(AnimationUpdateSample())),
    ]
}

struct DecorationCatalog_Previews: PreviewProvider {
    static var previews: some View {
        DecorationCatalog()
    }
}
