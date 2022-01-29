//
//  StackCardCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/29.
//

import SwiftUI

struct StackCardCatalog: View {
    var body: some View {
        List(stackCardSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }
    
    let stackCardSamples = [
        Sample(title: "LeaningCardSample \n 斜めのカードUI", desinationView: AnyView(LeaningCardSample())),
        Sample(title: "StackLayoutSample\n 重なったカードUI", desinationView: AnyView(StackLayoutSample())),
        Sample(title: "LeaningStackSample\n 斜めのカードが重なったUI", desinationView: AnyView(LeaningStackSample())),
        Sample(title: "TextCardsStackSample\n 斜めのテキストカードが重なったUI", desinationView: AnyView(TextCardsStackSample())),
        Sample(title: "StackCardsAnimationSample \n 重なったカードのアニメーション", desinationView: AnyView(StackCardsAnimationSample())),
        Sample(title: "StackCardsAnimationAndDragGestureSample \n 重なったカードのアニメーション&ドラッグジェスチャー ", desinationView: AnyView(StackCardsAnimationAndDragGestureSample())),
    ]
}

struct StackCardCatalog_Previews: PreviewProvider {
    static var previews: some View {
        StackCardCatalog()
    }
}
