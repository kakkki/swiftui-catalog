//
//  AnchorPreferenceSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2021/12/29.
//

import SwiftUI

struct AnchorPreferenceSample: View {

    @State private var activeIdx: Int = 0

        var body: some View {
           VStack {
               Spacer()

               HStack {
                   MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                   MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                   MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                   MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
               }

               Spacer()

               HStack {
                   MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                   MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                   MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                   MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
               }

               Spacer()

               HStack {
                   MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                   MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                   MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                   MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
               }

               Spacer()
           }.backgroundPreferenceValue(MyTextPreferenceKey.self) { preferences in
               return GeometryReader { geometry in
                   ZStack(alignment: .topLeading) {
                       self.createBorder(geometry, preferences)
                       HStack { Spacer() } // makes the ZStack to expand horizontally
                       VStack { Spacer() } // makes the ZStack to expand vertically
                   }.frame(alignment: .topLeading)
               }
           }
       }

       //  CGRect
       func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceDataAnchor]) -> some View {
           print("debug0000 geometry.size.debugDescription : \(geometry.size.debugDescription)")
           print("debug0000 preferences.debugDescription : \(preferences.debugDescription)")

           
           
           let p = preferences.first(where: { $0.viewIdx == self.activeIdx })
           
           print("debug0000 p.debugDescription : \(p.debugDescription)")
           print("debug0000 p!.bounds : \(p!.bounds)")
           print("debug0000 geometry : \(geometry)")
           print("debug0000 geometry[p!.bounds] : \(geometry[p!.bounds])")

           let bounds = p != nil ? geometry[p!.bounds] : .zero
           
           print("debug0000 createBorder bounds.minX : \(bounds.minX) ")
           print("debug0000 createBorder bounds.minY : \(bounds.minY) ")
           return RoundedRectangle(cornerRadius: 15)
                   .stroke(lineWidth: 3.0)
                   .foregroundColor(Color.green)
                   .frame(width: bounds.size.width, height: bounds.size.height)
                   .fixedSize()
                   .offset(x: bounds.minX, y: bounds.minY)
                   .animation(.easeInOut(duration: 1.0))
       }
}

// CGRect
struct MyTextPreferenceDataAnchor {
    let viewIdx: Int
    let bounds: Anchor<CGRect>
}

private struct MyTextPreferenceKey: PreferenceKey {
    typealias Value = [MyTextPreferenceDataAnchor]

    static var defaultValue: [MyTextPreferenceDataAnchor] = []

    static func reduce(value: inout [MyTextPreferenceDataAnchor], nextValue: () -> [MyTextPreferenceDataAnchor]) {
        value.append(contentsOf: nextValue())
    }
}

private struct MonthView: View {
    @Binding var activeMonth: Int
    let label: String
    let idx: Int

    var body: some View {
        Text(label)
            .padding(10)
            .anchorPreference(key: MyTextPreferenceKey.self, value: .bounds, transform: { [MyTextPreferenceDataAnchor(viewIdx: self.idx, bounds: $0)] })
            .onTapGesture { self.activeMonth = self.idx }
    }
}

struct AnchorPreferenceSample_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPreferenceSample()
    }
}
