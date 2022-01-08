//
//  ContentView.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2021/12/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(samples) { sample in
                NavigationLink(sample.title, destination: sample.desinationView)
            }
        }
    }
}

struct Sample: Identifiable {
    let id = UUID()
    let title: String
    let desinationView: AnyView
}

let samples:[Sample] = [
    Sample(title: "SyncColumnWidthSample", desinationView: AnyView(SyncColumnWidthSample())),
    Sample(title: "GeometryPreferenceSample", desinationView: AnyView(GeometryPreferenceSample())),
    Sample(title: "AnchorPreferenceSample", desinationView: AnyView(AnchorPreferenceSample())),
    Sample(title: "NestedViewPreferenceSample", desinationView: AnyView(NestedViewPreferenceSample())),
    Sample(title: "SetPositionToCenterExample", desinationView: AnyView(SetPositionToCenterExample())),
    Sample(title: "TrackableScrollViewSample todo implement", desinationView: AnyView(TrackableScrollViewSample())),
    Sample(title: "FeaturedItem", desinationView: AnyView(FeaturedItem())),
    Sample(title: "TabbedFeaturedItems", desinationView: AnyView(TabbedFeaturedItems())),
    Sample(title: "Rotation3DEffectTab", desinationView: AnyView(Rotation3DEffectTab())),
    Sample(title: "DragGesture Basic", desinationView: AnyView(DragGestureBasic()))

]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
