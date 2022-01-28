//
//  ContentView.swift
//  swiftui-catalog
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
    let desinationView: AnyView?
}

let samples:[Sample] = [
    Sample(title: "--- CategoryFeatureList-----", desinationView: AnyView(CategoryFeatureList())),
    Sample(title: "--- 🗺GeometryReader🗺 ----------", desinationView: nil),
    Sample(title: "SyncColumnWidthSample", desinationView: AnyView(SyncColumnWidthSample())),
    Sample(title: "GeometryPreferenceSample", desinationView: AnyView(GeometryPreferenceSample())),
    Sample(title: "AnchorPreferenceSample", desinationView: AnyView(AnchorPreferenceSample())),
    Sample(title: "NestedViewPreferenceSample", desinationView: AnyView(NestedViewPreferenceSample())),
    Sample(title: "SetPositionToCenterExample", desinationView: AnyView(SetPositionToCenterExample())),
    Sample(title: "PositionChangeExample", desinationView: AnyView(PositionChangeExample())),
    Sample(title: "TrackableScrollViewSample todo implement", desinationView: AnyView(TrackableScrollViewSample())),
    Sample(title: "---汎用的-----------------------------------", desinationView: nil),
    Sample(title: "VStackSpacerLayoutSample", desinationView: AnyView(VStackSpacerLayoutSample())),
    Sample(title: "EditableListSample", desinationView: AnyView(EditableListSample())),
    Sample(title: "--------------------------------------", desinationView: nil),
    Sample(title: "FeaturedItem", desinationView: AnyView(FeaturedItem())),
    Sample(title: "TabbedFeaturedItems", desinationView: AnyView(TabbedFeaturedItems())),
    Sample(title: "Rotation3DEffectTab", desinationView: AnyView(Rotation3DEffectTab())),
    Sample(title: "--------------------------------------", desinationView: nil),
    Sample(title: "Replace Animation API from iOS15", desinationView: AnyView(AnimationUpdateSample())),
    Sample(title: "LeaningCardSample \n 斜めのカードUI", desinationView: AnyView(LeaningCardSample())),
    Sample(title: "StackLayoutSample\n 重なったカードUI", desinationView: AnyView(StackLayoutSample())),
    Sample(title: "LeaningStackSample\n 斜めのカードが重なったUI", desinationView: AnyView(LeaningStackSample())),
    Sample(title: "TextCardsStackSample\n 斜めのテキストカードが重なったUI", desinationView: AnyView(TextCardsStackSample())),
    Sample(title: "StackCardsAnimationSample \n 重なったカードのアニメーション", desinationView: AnyView(StackCardsAnimationSample())),
    Sample(title: "StackCardsAnimationAndDragGestureSample \n 重なったカードのアニメーション&ドラッグジェスチャー ", desinationView: AnyView(StackCardsAnimationAndDragGestureSample())),
    Sample(title: "--------------------------------------", desinationView: nil),
    Sample(title: "DashedLineSample", desinationView: AnyView(DashedLineSample())),
    Sample(title: "LayoutUsingSpacerSample", desinationView: AnyView(LayoutUsingSpacerSample())),
    Sample(title: "Overlayの検証", desinationView: AnyView(DragGestureBasic())),
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
