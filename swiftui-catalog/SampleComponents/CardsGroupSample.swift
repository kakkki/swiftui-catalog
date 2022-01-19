//
//  CardsGroupSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/18.
//

import SwiftUI

private enum Signal {
    case nonSelected
    case groupSelected(Int)

    func tappedResult(_ id: Int) -> TappedResult {
        switch self {
        case .nonSelected:
            return .select
        case .groupSelected(let int):
            return id == int ? .unSelect : .nothing
        }
    }
    
    func shouldBlur(_ id: Int) -> Bool {
        switch self {
        case .nonSelected:
            return false
        case .groupSelected(let int):
            return id == int ? false : true
        }
    }
    
    func shouldBlur() -> Bool {
        switch self {
        case .nonSelected:
            return false
        case .groupSelected(let int):
            return true
        }
    }
}

private enum TappedResult {
    case nothing
    case select
    case unSelect
}

struct CardsGroupSample: View {
    
    @State fileprivate var signal: Signal = .nonSelected
    @State fileprivate var preferenceDataList: [CardsFolderPreferenceData] = []
    
    var body: some View {
        VStack() {
            Rectangle()
                .foregroundColor(.orange)
//                .frame(height: 200)
                .opacity(0.2)
            
            /**
             TODO: どのCardsGroupを選択しても、画面全体での同じ座標でカードを展開する
             
             Hint:
             ・CardsGroupごとにAnchorPreferenceで、bodyにおけるboundsが取得できる
             ・そのboundsでCardsGroup内で、進んでしまってる分引いてあげれば、毎回同じ座標を起点に展開できそう
             ・AnchorPreferenceSampleではbody直下のRectangleを移動させてた
                <-> 今回はCardsGroup内のViewを移動させる
             */

            HStack(spacing: 10) {
                CardsGroup(id: 1, signal: $signal, preferenceDataList: $preferenceDataList)
                CardsGroup(id: 2, signal: $signal, preferenceDataList: $preferenceDataList)
                CardsGroup(id: 3, signal: $signal, preferenceDataList: $preferenceDataList)
            }
            .padding(.leading, 10)
            
            Spacer()
                .frame(height: 60)
            
            HStack(spacing: 10) {
                CardsGroup(id: 4, signal: $signal, preferenceDataList: $preferenceDataList)
                CardsGroup(id: 5, signal: $signal, preferenceDataList: $preferenceDataList)
                CardsGroup(id: 6, signal: $signal, preferenceDataList: $preferenceDataList)
            }
            .padding(.leading, 10)

            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                    .opacity(0.2)
                Text("// TODO: ページングボタン実装")
                    .foregroundColor(.blue)
            }
            .frame(height: 80)
            .blur(radius: self.signal.shouldBlur() ? 2 : 0)
        }

        .onPreferenceChange(CardsFolderPreferenceKey.self) { preferences in
            // @see https://swiftui-lab.com/state-changes/
            // [SwiftUI] Modifying state during view update, this will cause undefined behavior.
            // AnchorPreferenceを使用するとGeometryReader内で値を取得するので
            // Viewを生成するコードブロックの中で値を取得して、ViewのStateを更新するという処理になる
            // Viewを生成する処理の中でViewのStateを更新する処理を書くと、
            // Viewの評価 -> Stateの更新 -> Viewの再評価 という無限ループに入る恐れがあるため
            // SwiftUIが警告を出す
       
            // 今のところの俺の理解では、
            // Preferenceを使ってStateを更新するような処理がある場合は、
            // AnchorPreferenceはGeometryReaderが必要でViewの評価中にStateを更新せざるを得なくなるので、
            // onPreferenceChangeを使って、Viewの評価処理とは独立してPreferenceの変更を検知して処理するようにしたほうが良さそう

            let _ = print("debug0000 preferences.size : \(preferences.count)")
            let _ = preferences.map {
                let _ = print(
                    "debug0000 id : \($0.viewIdx) | minx : \($0.rect.minX) | minY : \($0.rect.minY)"
                )
            }

            self.preferenceDataList = preferences.map {
                CardsFolderPreferenceData(viewIdx: $0.viewIdx, rect: $0.rect)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct CardsGroup: View {
    @State private var show = false
    
    var id: Int
    @Binding var signal: Signal
    @Binding var preferenceDataList: [CardsFolderPreferenceData]

    var body: some View {
        
        // ついにそれぞれのCardGroupが、global座標空間における全てのカードの座標を取得できた
        let _ = preferenceDataList.map {
            let _ = print(
                "debug0000 in CardsGroup id : \($0.viewIdx) | minx : \($0.rect.minX) | minY : \($0.rect.minY)"
            )
        }

        GeometryReader { geometry in
            ZStack {
    //            DraggableCard(
    //                show: $show,
    //                text: "Hello5",
    //                color: Color("card1"),
    //                scale: 0.80,
    //                heightOffsetOnHide: -45,
    //                heightOffsetOnShow: -200
    //            )
    //            .rotationEffect(Angle.degrees(30))
    //
    //            DraggableCard(
    //                show: $show,
    //                text: "Hello4",
    //                color: Color("card2"),
    //                scale: 0.80,
    //                heightOffsetOnHide: -40,
    //                heightOffsetOnShow: -200
    //            )
    //            .rotationEffect(Angle.degrees(20))
    //
    //            DraggableCard(
    //                show: $show,
    //                text: "Hello3",
    //                color: Color("card2"),
    //                scale: 0.85,
    //                heightOffsetOnHide: -30,
    //                heightOffsetOnShow: -200
    //            )
    //            .rotationEffect(Angle.degrees(10))
    //
    //            DraggableCard(
    //                show: $show,
    //                text: "Hello2",
    //                color: Color("card4"),
    //                scale: 0.9,
    //                heightOffsetOnHide: -20,
    //                heightOffsetOnShow: -200
    //            )
    //            .rotationEffect(Angle.degrees(5))

                // 5枚目
                DraggableCard(
                    show: $show,
                    text: "Hello6",
                    color: Color("card1"),
                    scale: 0.9,
                    heightOffsetOnHide: -45,
                    heightOffsetOnShow: -219,
                    widthOffsetOnShow: 144
                )

                // 4枚目
                DraggableCard(
                    show: $show,
                    text: "Hello5",
                    color: Color("card1"),
                    scale: 0.9,
                    heightOffsetOnHide: -45,
                    heightOffsetOnShow: -219,
                    widthOffsetOnShow: 0
                )

                // 3枚目
                DraggableCard(
                    show: $show,
                    text: "Hello4",
                    color: Color("card2"),
                    scale: 0.9,
                    heightOffsetOnHide: -40,
                    heightOffsetOnShow: -339,
                    widthOffsetOnShow: 294
                )
                
                // 2枚目
                DraggableCard(
                    show: $show,
                    text: "Hello3",
                    color: Color("card2"),
                    scale: 0.9,
                    heightOffsetOnHide: -30,
                    heightOffsetOnShow: -339,
                    widthOffsetOnShow: 144
                )
                            
                // 1枚目
                DraggableCard(
                    show: $show,
                    text: "Hello2",
                    color: Color("card4"),
                    scale: 0.9,
                    heightOffsetOnHide: -20,
                    heightOffsetOnShow: -339,
                    widthOffsetOnShow: 0
                )
                
                // Front Card
                DraggableCard(
                    show: $show,
                    text: "Hello1",
                    color: Color("card3"),
                    scale: 1.0,
                    heightOffsetOnHide: 0,
                    heightOffsetOnShow: 0,
                    widthOffsetOnShow: 0
                )
                .onTapGesture {
                    switch self.signal.tappedResult(id) {
                    case .nothing: break
                    case .select:
                        self.show.toggle()
                        self.signal = .groupSelected(id)
                    case .unSelect:
                        self.show.toggle()
                        self.signal = .nonSelected
                    }
                }
                .preference(key: CardsFolderPreferenceKey.self, value: [CardsFolderPreferenceData(viewIdx: self.id, rect: geometry.frame(in: .global))])
            }
            .blur(radius: self.signal.shouldBlur(id) ? 2 : 0)
        }
        .frame(width: 120, height: 100)

    }
}

// CGRect
private struct CardsFolderPreferenceData: Equatable {
    let viewIdx: Int
    let rect: CGRect
}

private struct CardsFolderPreferenceKey: PreferenceKey {
    typealias Value = [CardsFolderPreferenceData]

    static var defaultValue: [CardsFolderPreferenceData] = []

    static func reduce(value: inout [CardsFolderPreferenceData], nextValue: () -> [CardsFolderPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

private struct DraggableCard: View {
    @Binding var show: Bool
    var text: String
    var color: Color
    var scale: CGFloat
    var heightOffsetOnHide: CGFloat
    var heightOffsetOnShow: CGFloat
    var widthOffsetOnShow: CGFloat

    @State var translationSize = CGSize.zero
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if (show) {
                    self.translationSize = value.translation
                }
            }
            .onEnded { value in
                if (show) {
                    self.translationSize = .zero
                }
            }
    }

    var body: some View {
        ZStack {
            Text(text)
                .frame(width: 120, height: 100)
                .background(color)
                .cornerRadius(20)
                .shadow(radius: 10)
                .offset(
                    x: show ? widthOffsetOnShow : 0,
                    y: show ? heightOffsetOnShow : heightOffsetOnHide
                )
                .scaleEffect(scale)
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5), value: show)
        }
        .offset(x: translationSize.width, y: translationSize.height)
        .gesture(drag)
    }
}
struct CardsGroup_Previews: PreviewProvider {
    static var previews: some View {
        CardsGroupSample()
    }
}
