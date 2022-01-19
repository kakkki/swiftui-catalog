//
//  CoordinateSpaceAndDragSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/19.
//

import SwiftUI

struct CoordinateSpaceAndDragSample: View {
//    @State var location = CGPoint.zero
//    @State var translationSize = CGSize.zero

    @State var dragValue: DragGesture.Value? = nil
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 200)
                .foregroundColor(.orange)
                .opacity(0.2)

            VStack {
                Rectangle()
                    .foregroundColor(.clear)
//                Color.red.frame(width: 100, height: 100)
    //                .overlay(circle)
//                circle

                // 座標情報をText()で描画しようとすると、
                // 更新処理が多すぎるせいかSwiftUIが処理しきれずにクラッシュする
    //            Text("Location: \(Int(self.dragValue != nil ? self.dragValue!.location.x : 0)), \(Int(self.dragValue != nil ? self.dragValue!.location.y : 0))")
                let _  = print("debug0000 (\(Int(self.dragValue != nil ? self.dragValue!.location.x : 9999999)), \(Int(self.dragValue != nil ? self.dragValue!.location.y : 9999999)))")
            }
            .background(.blue)
            .opacity(0.2)
            .overlay(circle)

            Rectangle()
                .frame(height: 200)
                .foregroundColor(.orange)
                .opacity(0.2)
        }
        .coordinateSpace(name: "stack")
    }

    var circle: some View {
        Circle()
            .frame(width: 120, height: 100)
            .gesture(drag)
            .padding(5)
            .offset(
                x: dragValue != nil ? dragValue?.translation.width as! CGFloat : 0,
                y: dragValue != nil ? dragValue?.translation.height as! CGFloat : 0
            )

    }

    var drag: some Gesture {
        DragGesture(coordinateSpace: .named("stack"))
            .onChanged { info in
//                location = info.location
//                self.translationSize = info.translation
                self.dragValue = info
            }
            .onEnded { info in
//                self.translationSize = .zero
                self.dragValue = nil
            }
    }
}

struct CoordinateSpaceAndDragSample_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSpaceAndDragSample()
    }
}
