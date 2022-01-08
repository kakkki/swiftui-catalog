//
//  SyncColumnWidthSample.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2021/12/29.
//

import SwiftUI

struct SyncColumnWidthSample: View {
    @State var value1 = ""
    @State var value2 = ""
    @State var value3 = ""
    @State var width: CGFloat? = nil
    
    var body: some View {
        // 1
        let _ = print("debug0000: ContentView initialize width : \(width)")
        Form {
            HStack {
                Text("First Item")
                    .frame(width: width, alignment: .leading)
                    // 3
                    .background(ColumnWidthEqualiserView())
                TextField("Enter first item", text: $value1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Second Item")
                    .frame(width: width, alignment: .leading)
                    // 4
                    .background(ColumnWidthEqualiserView())
                TextField("Enter second item", text: $value2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Final  Item")
                    .frame(width: width, alignment: .leading)
                    // 5
                    .background(ColumnWidthEqualiserView())
                TextField("Enter third item", text: $value3)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        // 2
        .modifier(ColumnWidth(width: $width))
    }
}

struct ColumnWidthPreference: Equatable {
    let width: CGFloat
}

struct ColumnWidthPreferenceKey: PreferenceKey {
    typealias Value = [ColumnWidthPreference]
    
    static var defaultValue: [ColumnWidthPreference] = []
    
    static func reduce(value: inout [ColumnWidthPreference], nextValue: () -> [ColumnWidthPreference]) {
        value.append(contentsOf: nextValue())
    }
}

struct ColumnWidth: ViewModifier {
    @Binding var width: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ColumnWidthPreferenceKey.self) { preferences in
                let _ = print("debug0000: onPreferenceChange : \(preferences.debugDescription)")
                for p in preferences {
                    let oldWidth = self.width ?? CGFloat.zero
                    let _ = print("debug0000: oldWidth : \(oldWidth)")
                    if p.width > oldWidth {
                        self.width = p.width + 20
                    }
                }
            }
    }
}

struct ColumnWidthEqualiserView: View {
    var body: some View {
        let _ = print("debug0000: initialize ColumnWidthEqualiserView")
        GeometryReader { geometry in
            let _ = print("debug0000: GeometryReader closure : \(geometry.frame(in: CoordinateSpace.global).width)")
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: ColumnWidthPreferenceKey.self,
                    value: [ColumnWidthPreference(width: geometry.frame(in: CoordinateSpace.global).width)]
                )
        }
    }
}


struct SyncColumnWidthSample_Previews: PreviewProvider {
    static var previews: some View {
        SyncColumnWidthSample()
    }
}
