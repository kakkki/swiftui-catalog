//
//  TrackableScrollViewSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/03.
//

import SwiftUI
import SwiftUIVisualEffects

struct TrackableScrollViewSample: View {
    @State private var contentOffset = CGFloat(0)
    
    var body: some View {
        ZStack(alignment: .top) {
            TrackableScrollView(offsetChanged: { offsetPoint in
                contentOffset = offsetPoint.y
            }) {
                Text("Hello, world!")
            }

            // SwiftUIVisualEffectsを利用した例
            Rectangle()
                .frame(width: .infinity)
                .opacity(contentOffset < -16 ? 1 : 0)
                .animation(.easeIn)
                .ignoresSafeArea()
                .frame(height: 0)
                .vibrancyEffect()
                .vibrancyEffectStyle(.fill)

//            VisualEffectBlur(blurStyle: .systemMaterial)
//                .opacity(contentOffset < -16 ? 1 : 0)
//                .animation(.easeIn)
//                .ignoresSafeArea()
//                .frame(height: 0)
            // ignoresSafeArea とheight0によって、
            // ContentエリアはVisualEffectBlurが適用されない
            // その結果ステータスバーのみにエフェクトがかかる
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(AccountBackground())
    }
}

struct TrackableScrollView<Content: View>: View {
    let axes: Axis.Set
    let offsetChanged: (CGPoint) -> Void
    let content: Content

    init(
        axes: Axis.Set = .vertical,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes) {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: geometry.frame(in: .named("scrollView")).origin
                    )
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
    }
}

struct TrackableScrollViewSample_Previews: PreviewProvider {
    static var previews: some View {
        TrackableScrollViewSample()
    }
}
