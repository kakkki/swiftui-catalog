//
//  GestureCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct GestureCatalog: View {
    var body: some View {
        List(gestureSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let gestureSamples = [
        Sample(title: "--- LongPressGestureSample -----", desinationView: AnyView(LongPressGestureSample())),
        Sample(title: "--- LongPressGestureSampleSecond -----", desinationView: AnyView(LongPressGestureSampleSecond())),
        Sample(title: "StackCardsDragSample\nスタックしてるカードをタップしてドラッグする部品ができた -----", desinationView: AnyView(StackCardsDragSample())),
        Sample(title: "CardsGroupSample\n展開するカードのグループパーツ", desinationView: AnyView(CardsGroupSample())),
        Sample(title: "DragGesture Basic", desinationView: AnyView(DragGestureBasic())),
        Sample(title: "DragGestureAutoPositionChange \n AnchorPreferenceによる座標取得とドラッグジェスチャーでの座標による制御処理", desinationView: AnyView(DragGestureAutoPositionChange())),
        Sample(title: "positionを使わないことでコンテンツサイズを超える大きさでの領域で描画されるのを防ぐ", desinationView: AnyView(DragGestureNotUsePosition())),
        Sample(title: "TaskDragSample", desinationView: AnyView(TaskDragSample())),
        Sample(title: "CoordinateSpaceAndDragSample", desinationView: AnyView(CoordinateSpaceAndDragSample())),
    ]
}

struct GestureCatalog_Previews: PreviewProvider {
    static var previews: some View {
        GestureCatalog()
    }
}
