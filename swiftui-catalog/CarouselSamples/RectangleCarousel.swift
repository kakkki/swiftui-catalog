//
//  RectangleCarousel.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct RectangleCarousel: View {
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var examples = ["1", "2", "3", "4"]
    
    let itemPadding: CGFloat = 20
    
    var body: some View {
        GeometryReader { bodyView in
            LazyHStack(spacing: itemPadding) {
                ForEach(examples.indices, id: \.self) { index in
                    // カルーセル対象のView
                    Text(examples[index])
                        .foregroundColor(Color.white)
                        .font(.system(size: 50, weight: .bold))
                        .frame(width: bodyView.size.width * 0.8, height: 300)
                        .background(Color.gray)
                        .padding(.leading, index == 0 ? bodyView.size.width * 0.1 : 0)
                }
            }
            // currentIndex変更前のドラッグに対応したアニメーションに必要
            .offset(x: self.dragOffset)
            .offset(x: -CGFloat(self.currentIndex) * (bodyView.size.width * 0.8 + itemPadding))
            .gesture(
                DragGesture()
                    .updating(self.$dragOffset, body: { (value, state, _) in
                        // 先頭・末尾ではスクロールする必要がないので、画面サイズの1/5までドラッグで制御する
                        print("debug0000 value.translation.width : \(value.translation.width)")
                        if self.currentIndex == 0, value.translation.width > 0 {
                            state = value.translation.width / 5
                        } else if self.currentIndex == (self.examples.count - 1), value.translation.width < 0 {
                            state = value.translation.width / 5
                        } else {
                            state = value.translation.width
                        }
                    })
                    .onEnded({ value in
                        var newIndex = self.currentIndex
                        // ドラッグ幅からページングを判定
                        if abs(value.translation.width) > bodyView.size.width * 0.3 {
                            // ドラッグした値がプラスなら右にスクロールしてるので、インデックスは下がる
                            newIndex = value.translation.width > 0 ? self.currentIndex - 1 : self.currentIndex + 1
                        }
                        
                        // 最小ページ、最大ページを超えないようチェック
                        if newIndex < 0 {
                            newIndex = 0
                        } else if newIndex > (self.examples.count - 1) {
                            newIndex = self.examples.count - 1
                        }
                        
                        self.currentIndex = newIndex
                    })
            )
        }
        .animation(.interpolatingSpring(mass: 0.6, stiffness: 150, damping: 80, initialVelocity: 0.1))
    }
}

struct RectangleCarousel_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCarousel()
    }
}
