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
    Sample(title: "--------------------------------------", desinationView: nil),
    Sample(title: "LeaningCardSample \n 斜めのカードUI", desinationView: AnyView(LeaningCardSample())),
    Sample(title: "StackLayoutSample\n 重なったカードUI", desinationView: AnyView(StackLayoutSample())),
    Sample(title: "LeaningStackSample\n 斜めのカードが重なったUI", desinationView: AnyView(LeaningStackSample())),
    Sample(title: "TextCardsStackSample\n 斜めのテキストカードが重なったUI", desinationView: AnyView(TextCardsStackSample())),
    Sample(title: "StackCardsAnimationSample \n 重なったカードのアニメーション", desinationView: AnyView(StackCardsAnimationSample())),
    Sample(title: "StackCardsAnimationAndDragGestureSample \n 重なったカードのアニメーション&ドラッグジェスチャー ", desinationView: AnyView(StackCardsAnimationAndDragGestureSample())),
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
