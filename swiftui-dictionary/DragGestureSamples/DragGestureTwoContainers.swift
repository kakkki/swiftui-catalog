//
//  DragGestureTwoContainers.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/08.
//

import SwiftUI

struct DragGestureTwoContainers: View {
    @State var position = CGSize(width: 200, height: 300)
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(height: 200)
                Rectangle()
                    .foregroundColor(.green)
                    .frame(height: 400)

                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 200)

            }
                
                
            
            
            Text("Image Center x: \(position.width)")
                .position(x: 200, y: 100)
            Text("Image Center y: \(position.height)")
                .position(x: 200, y: 125)
            
            
            // 1. このRectangleの中心点を描画したい
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
                .position(x: position.width, y: position.height)
                .gesture(drag)

            // 2. 各Containerのどれかにドラッグした場合に、左上から順番に、
            // コンテナ内の決められた座標にViewを配置orアニメーションする動きを作りたい
            // -> ドラッグジェスチャーでメモを管理できるアプリができそう
            
//            Image("Illustration 5")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 150)
//            // Positions the center of this view at the specified coordinates in its parent’s coordinate space.
//                .position(x: position.width, y: position.height)
//                .gesture(drag)
//                .foregroundColor(.blue)
            
        }
    }}

struct DragGestureTwoContainers_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureTwoContainers()
    }
}
