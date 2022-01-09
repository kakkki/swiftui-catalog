//
//  DragGestureAutoPositionChange.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/08.
//

import SwiftUI

/**

 1. DragGesture.onEndedでどのコンテナに被ってる面積が一番大きいか判定する
    これができたら、実現する材料はそろったようなもの
    別に面積じゃなくていいわ
    -> ひとまずheightで判定しよう
        -> DragGesture.onEndedのvalue.startLocation.y + value.translation.heightでheithtの判定ができた
 2. 判定されたコンテナの対象のCGPointにpositionを変更する
    (PositionChangeExampleを参考に)
 */

struct DragGestureAutoPositionChange: View {
    @State var position = CGSize(width: 200, height: 300)
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
            .onEnded { value in
                // 88,718
                
                print("debug0000 value.startLocation.y + value.translation.height : \(value.startLocation.y + value.translation.height)")

                // 固定値でひとまず検証
                // 紫エリアの一番左の枠の中心に自動配置する処理
                if (value.startLocation.y + value.translation.height >= 616.0) {
                    self.position = CGSize(width: 88.0, height: 718.0)
                }
            }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(height: 200)
                    .background(ContainerReader(id: 1))
                Rectangle()
                    .foregroundColor(.green)
                    .frame(height: 400)
                    .background(ContainerReader(id: 2))
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.purple)
                        .frame(height: 200)
                        .background(ContainerReader(id: 3))
                    
                    // サンプルとして赤線枠を描画
                    HStack {
                        Rectangle()
                            .stroke(.red)
                            .frame(width: 100, height: 100, alignment: .topLeading)
                            .padding(.horizontal, 10)
                        
                        Rectangle()
                            .stroke(.red)
                            .frame(width: 100, height: 100, alignment: .topLeading)
                            .padding(.horizontal, 10)
                        Rectangle()
                            .stroke(.red)
                            .frame(width: 100, height: 100, alignment: .topLeading)
                            .padding(.horizontal, 10)
                    }
                }
            }
                
            Text("Image Center x: \(position.width)")
                .position(x: 200, y: 100)
            Text("Image Center y: \(position.height)")
                .position(x: 200, y: 125)
            
            
            // 1. このRectangleの中心点を描画したい
            // anchorPreferenceを使えばCenterのCGPointが取れるので簡単
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .position(x: position.width, y: position.height)
                .gesture(drag)

            // 2. 各Containerのどれかにドラッグした場合に、左上から順番に、
            // コンテナ内の決められた座標にViewを配置orアニメーションする動きを作りたい
            // -> ドラッグジェスチャーでメモを管理できるアプリができそう
            
        }.overlayPreferenceValue(DragGestureContainerPreferences.self) { preferences in
            GeometryReader { proxy in
                let top1 = proxy[preferences[0].top].y
                let top2 = proxy[preferences[1].top].y
                let top3 = proxy[preferences[2].top].y
                VStack {
                    Text("id : \(preferences[0].id) | top : \(top1)")
                    Text("id : \(preferences[1].id) | top : \(top2)")
                    Text("id : \(preferences[2].id) | top : \(top3)")
                }.padding()
            }
        }
    }
}

struct DragGestureContainerData: Identifiable {
    let id: Int
    let top: Anchor<CGPoint>
}

struct DragGestureContainerPreferences: PreferenceKey {
    static var defaultValue: [DragGestureContainerData] = []

    static func reduce(value: inout [DragGestureContainerData], nextValue: () -> [DragGestureContainerData]) {
        value.append(contentsOf: nextValue())
    }
}

struct ContainerReader: View {
    let id: Int
    var body: some View {
        Color.clear.anchorPreference(key: DragGestureContainerPreferences.self, value: .top) {
            [DragGestureContainerData(id: id, top: $0)]
        }
    }
}

struct DragGestureAutoPositionChange_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureAutoPositionChange()
    }
}
