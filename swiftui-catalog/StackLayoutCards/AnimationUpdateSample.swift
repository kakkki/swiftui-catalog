//
//  AnimationUpdateSample.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/12.
//

import SwiftUI

struct AnimationUpdateSample: View {
    @State private var scaledUp = true
    
    var body: some View {
        VStack {
            // 何も条件付けせずにanimation modifierを書いてるので、
            // 画面遷移時や画面回転時など、意図しないタイミングでアニメーション処理が走ってしまう
            Text("Old Animation API")
                .scaleEffect(scaledUp ? 2 : 1)
                .animation(.linear(duration: 2))
                .onTapGesture { scaledUp.toggle() }
            
            Spacer()
                .frame(height: 60)
            
            // @see https://www.hackingwithswift.com/articles/235/whats-new-in-swiftui-for-ios-15

            // valueに渡したscaledUpの値が変更されたときだけ、
            // アニメーション処理が走る
            Text("New Animation API")
                .scaleEffect(scaledUp ? 2 : 1)
                .animation(.linear(duration: 2), value: scaledUp)
                .onTapGesture { scaledUp.toggle() }
        }
    }
}

struct AnimationUpdateSample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationUpdateSample()
    }
}
