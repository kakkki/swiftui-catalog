//
//  SetPositionToCenterExample.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/08.
//

// @see https://stackoverflow.com/questions/60494745/swiftui-set-position-to-center-of-different-view

import SwiftUI

struct PositionData: Identifiable {
    let id: Int
    let center: Anchor<CGPoint>
}
struct Positions: PreferenceKey {
    static var defaultValue: [PositionData] = []
    static func reduce(value: inout [PositionData], nextValue: () -> [PositionData]) {
        value.append(contentsOf: nextValue())
    }
}

struct PositionReader: View {
    let tag: Int
    var body: some View {
        Color.clear.anchorPreference(key: Positions.self, value: .center) { (anchor)  in
                [PositionData(id: self.tag, center: anchor)]
        }
    }
}

struct SetPositionToCenterExample: View {
    @State var tag = 0
    var body: some View {
        ZStack {
            VStack {
                Color.green.background(PositionReader(tag: 0))
                    .onTapGesture {
                    self.tag = 0
                }
                HStack {
                    Rectangle()
                        .foregroundColor(Color.red)
                        .aspectRatio(1, contentMode: .fit)
                        .background(PositionReader(tag: 1))
                        .onTapGesture {
                            self.tag = 1
                        }
                    Rectangle()
                        .foregroundColor(Color.red)
                        .aspectRatio(1, contentMode: .fit)
                        .background(PositionReader(tag: 2))
                        .onTapGesture {
                            self.tag = 2
                        }
                    Rectangle()
                        .foregroundColor(Color.red)
                        .aspectRatio(1, contentMode: .fit)
                        .background(PositionReader(tag: 3))
                        .onTapGesture {
                            self.tag = 3
                        }
                }
            }
        }.overlayPreferenceValue(Positions.self) { preferences in
            GeometryReader { proxy in
                Rectangle().frame(width: 50, height: 50).position( self.getPosition(proxy: proxy, tag: self.tag, preferences: preferences))
            }
        }
    }
    func getPosition(proxy: GeometryProxy, tag: Int, preferences: [PositionData])->CGPoint {
        let p = preferences.filter({ (p) -> Bool in
            p.id == tag
            })[0]
        return proxy[p.center]
    }
}

struct SetPositionToCenterExample_Previews: PreviewProvider {
    static var previews: some View {
        SetPositionToCenterExample()
    }
}
