//
//  PositionChangeExample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/09.
//

import SwiftUI

/**
 1. Viewのidに応じてViewのCenterのCGPointをanchorPreferenceで保存しておく
 2. 選択されてるViewが変更されたら、対応するCenterのCGPointを取得する
 3. ターゲットのViewのpositionに適応する
*/

struct RectanglePositions: PreferenceKey {
    // PositionDataはSetPositionToCenterExample.swiftで定義してる
    static var defaultValue: [PositionData] = []

    static func reduce(value: inout [PositionData], nextValue: () -> [PositionData]) {
        value.append(contentsOf: nextValue())
    }
}

struct PositionChangeExample: View {
    
    @State var currentTag: Int = 8
    
    var body: some View {
        ZStack {
            VStack {
                RectangleRow(id: 1, rectangleColor: .red, currentTag: $currentTag)
                RectangleRow(id: 4, rectangleColor: .orange, currentTag: $currentTag)
                RectangleRow(id: 7, rectangleColor: .yellow, currentTag: $currentTag)
                RectangleRow(id: 10, rectangleColor: .green, currentTag: $currentTag)
                RectangleRow(id: 13, rectangleColor: .blue, currentTag: $currentTag)
                RectangleRow(id: 16, rectangleColor: .purple, currentTag: $currentTag)
            }
        }.overlayPreferenceValue(RectanglePositions.self) { preferences in
            GeometryReader { proxy in
                let targetPreference = preferences.filter({
                    $0.id == currentTag
                })[0]
                Rectangle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .position(proxy[targetPreference.targetPosition])
            }
        }
    }
}

struct RectangleRow: View {
    let id: Int
    @State var rectangleColor: Color
    @Binding var currentTag: Int
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(rectangleColor)
                .aspectRatio(1, contentMode: .fit)
                .background(CenterPointRecorder(tag: id))
                .onTapGesture {
                    currentTag = id
                }

            Rectangle()
                .foregroundColor(rectangleColor)
                .aspectRatio(1, contentMode: .fit)
                .background(CenterPointRecorder(tag: id + 1))
                .onTapGesture {
                    currentTag = id + 1
                }

            Rectangle()
                .foregroundColor(rectangleColor)
                .aspectRatio(1, contentMode: .fit)
                .background(CenterPointRecorder(tag: id + 2))
                .onTapGesture {
                    currentTag = id + 2
                }
        }
    }
}

struct CenterPointRecorder: View {
    let tag: Int
    
    var body: some View {
        Color.clear.anchorPreference(key: RectanglePositions.self, value: .center) {
            [PositionData(id: self.tag, targetPosition: $0)]
        }
    }
}

struct PositionChangeExample_Previews: PreviewProvider {
    static var previews: some View {
        PositionChangeExample()
    }
}
