//
//  GestureCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct GestureCatalog: View {
    var body: some View {
        List(gestureSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let gestureSamples = [
        Sample(title: "--- LongPressGestureSample -----", desinationView: AnyView(LongPressGestureSample())),
        Sample(title: "--- LongPressGestureSampleSecond -----", desinationView: AnyView(LongPressGestureSampleSecond())),
    ]
}

struct GestureCatalog_Previews: PreviewProvider {
    static var previews: some View {
        GestureCatalog()
    }
}
