//
//  CardsGroupSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/18.
//

import SwiftUI

enum Signal {
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
}

enum TappedResult {
    case nothing
    case select
    case unSelect
}

struct CardsGroupSample: View {
    
    @State var signal: Signal = .nonSelected
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer()
            
            /**
             TODO: どのCardsGroupを選択しても、画面全体での同じ座標でカードを展開する
             
             Hint:
             ・CardsGroupごとにAnchorPreferenceで、bodyにおけるboundsが取得できる
             ・そのboundsでCardsGroup内で、進んでしまってる分引いてあげれば、毎回同じ座標を起点に展開できそう
             ・AnchorPreferenceSampleではbody直下のRectangleを移動させてた
                <-> 今回はCardsGroup内のViewを移動させる
             */
            
            HStack(spacing: 10) {
                CardsGroup(id: 1, signal: $signal)
                CardsGroup(id: 2, signal: $signal)
                CardsGroup(id: 3, signal: $signal)
            }
            HStack(spacing: 10) {
                CardsGroup(id: 4, signal: $signal)
                CardsGroup(id: 5, signal: $signal)
                CardsGroup(id: 6, signal: $signal)
            }
            HStack(spacing: 10) {
                CardsGroup(id: 7, signal: $signal)
                CardsGroup(id: 8, signal: $signal)
                CardsGroup(id: 9, signal: $signal)
            }
        }
    }
}

private struct CardsGroup: View {
    @State private var show = false
    
    var id: Int
    @Binding var signal: Signal

    var body: some View {
        ZStack {
            DraggableCard(
                show: $show,
                text: "Hello5",
                color: Color("card1"),
                scale: 0.80,
                heightOffsetOnHide: -45,
                heightOffsetOnShow: -200
            )
                .rotationEffect(Angle.degrees(30))

            DraggableCard(
                show: $show,
                text: "Hello4",
                color: Color("card2"),
                scale: 0.80,
                heightOffsetOnHide: -40,
                heightOffsetOnShow: -200
            )
                .rotationEffect(Angle.degrees(20))
            
            DraggableCard(
                show: $show,
                text: "Hello3",
                color: Color("card2"),
                scale: 0.85,
                heightOffsetOnHide: -30,
                heightOffsetOnShow: -200
            )
                .rotationEffect(Angle.degrees(10))
            
            DraggableCard(
                show: $show,
                text: "Hello2",
                color: Color("card4"),
                scale: 0.9,
                heightOffsetOnHide: -20,
                heightOffsetOnShow: -200
            )
                .rotationEffect(Angle.degrees(5))

            // Front Card
            DraggableCard(
                show: $show,
                text: "Hello1",
                color: Color("card3"),
                scale: 1.0,
                heightOffsetOnHide: 0,
                heightOffsetOnShow: 0
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
        }
        .blur(radius: self.signal.shouldBlur(id) ? 2 : 0)
    }
}

private struct DraggableCard: View {
    @Binding var show: Bool
    var text: String
    var color: Color
    var scale: CGFloat
    var heightOffsetOnHide: CGFloat
    var heightOffsetOnShow: CGFloat
    
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
                .offset(x: 0, y: show ? heightOffsetOnShow : heightOffsetOnHide)
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
