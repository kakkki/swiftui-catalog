//
//  NestedViewPreferenceSample.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2021/12/29.
//

import SwiftUI

enum MyViewType: Equatable {
    case formContainer
    case fieldContainer
    case field(Int)
    case title
    case twitterFieldContainer
    case twitterfield(Int)
    case miniMapArea
}

struct MyPreferenceData: Identifiable {
    var id = UUID()
    let vtype: MyViewType
    let bounds: Anchor<CGRect>
    
    func getColor() -> Color {
        switch vtype {
        case .field(let length):
            return length == 0 ? .red : (length < 3 ? .yellow : .green)
        case .title:
            return .purple
        case .fieldContainer:
            return .orange
        case .twitterFieldContainer:
            return .green
        default:
            return .gray
        }
    }
    
    func show() -> Bool {
        switch vtype {
        case .field(let int):
            return true
        case .title:
            return true
        case .fieldContainer:
            return true
        case .twitterfield(let int):
            return true
        case .twitterFieldContainer:
            return true
        default:
            return false
        }
    }
}

struct MyPreferenceKey: PreferenceKey {
    typealias Value = [MyPreferenceData]
    
    static var defaultValue: [MyPreferenceData] = []
    
    static func reduce(value: inout [MyPreferenceData], nextValue: () -> [MyPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct NestedViewPreferenceSample: View {
    
    @State private var fieldValues = Array<String>(repeating: "", count: 5)
    @State private var length: Float = 180
    @State private var twitterFieldPreset = false
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Color(white: 0.7)
                    .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                        return [MyPreferenceData(vtype: .miniMapArea, bounds: $0)]
                    }
//                    .padding(.top, 40.0)
                
//                    .padding(.leading, 20.0)
//                    .padding(.trailing, 20.0)
//                    .padding(.horizontal, 30)
                
                VStack(alignment: .center) {
                    VStack {
                        Text("Hello \(fieldValues[0]) \(fieldValues[1]) \(fieldValues[2])")
                            .font(.title).fontWeight(.bold)
                            .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                                return [MyPreferenceData.init(vtype: .title, bounds: $0)]
                        }
//                        Divider()
                    }

                    // Switch + Slider
                    HStack(alignment: .center) {
                        VStack {
                            Toggle(isOn: $twitterFieldPreset) { Text("") }
                            Text("twitter")
                        }

                        Slider(value: $length, in: 40...180).layoutPriority(1)
                    }.padding(10)

                    // First row of text fields
                    HStack {
                        MyFormField(fieldValue: $fieldValues[0], label: "First Name")
                        MyFormField(fieldValue: $fieldValues[1], label: "Middle Name")
                    }
                    HStack {
                        MyFormField(fieldValue: $fieldValues[2], label: "Last Name")
                        MyFormField(fieldValue: $fieldValues[3], label: "Email")
                    }

                    // Second row of text fields
//                    MyFormField(fieldValue: $fieldValues[4], label: "Twitter")
//                        .frame(width: CGFloat(length))
//                        .opacity(twitterFieldPreset ? 1 : 0)
                   TwitterFormField(fieldValue: $fieldValues[4], label: "Twitter")
                        .frame(width: CGFloat(length))
                        .opacity(twitterFieldPreset ? 1 : 0)

                    

                }.transformAnchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                    $0.append(MyPreferenceData(vtype: .formContainer, bounds: $1))
                }
                Spacer()
            }
            .overlayPreferenceValue(MyPreferenceKey.self) { preferences in
                GeometryReader { geometry in
                    MiniMap(geometry: geometry, preferences: preferences, twitterFieldPreset: $twitterFieldPreset)
                }
            }
        }
        .background(Color(white: 0.8))
//        .edgesIgnoringSafeArea(.all)
    }
}

struct MyFormField: View {
    @Binding var fieldValue: String
    let label: String
    
    var body: some View {
        // TextFieldのanchorPreferenceでTextFieldのboundsをPreferenceに記録する
        VStack(alignment: .leading) {
            Text(label)
            TextField("", text: $fieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                    return [MyPreferenceData(vtype: .field(self.fieldValue.count), bounds: $0)]
                }
        }
//        .frame(width: 200)
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(white: 0.9)))
        // ラベルのTextとTextFieldを含んだVStack全体のboundsをtransformAnchorPreferenceで記録する
        // TextFieldのanchorPreferenceでTextFieldのboundsをPreferenceに記録する
        .transformAnchorPreference(key: MyPreferenceKey.self, value: .bounds) {
            $0.append(MyPreferenceData(vtype: .fieldContainer, bounds: $1))
        }
    }
}

struct TwitterFormField: View {
    @Binding var fieldValue: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            TextField("", text: $fieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                    return [MyPreferenceData(vtype: .twitterfield(self.fieldValue.count), bounds: $0)]
                }
        }
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(white: 0.9)))
        .transformAnchorPreference(key: MyPreferenceKey.self, value: .bounds) {
            $0.append(MyPreferenceData(vtype: .twitterFieldContainer, bounds: $1))
        }
    }
}


struct MiniMap: View {
    let geometry: GeometryProxy
    let preferences: [MyPreferenceData]
    @Binding var twitterFieldPreset: Bool
    
    var body: some View {
        // Get the form container preference
        guard let formContainerAnchor = preferences.first(where: { $0.vtype == .formContainer })?.bounds else { return AnyView(EmptyView()) }
        
        // Get the minimap area container
        guard let miniMapAreaAnchor = preferences.first(where: { $0.vtype == .miniMapArea })?.bounds else { return AnyView(EmptyView()) }
        
        // Get the title preference
        guard let titleAnchor = preferences.first(where: { $0.vtype == .title })?.bounds else {
            return AnyView(EmptyView())
        }
        
        // Determine the size of the title
        let titleSize = geometry[titleAnchor].size
        
        
        // Calcualte a multiplier factor to scale the views from the form, into the minimap.
        let factor = geometry[formContainerAnchor].size.width / (geometry[miniMapAreaAnchor].size.width - 10.0)
        
        // Determine the position of the form
        let containerPosition = CGPoint(x: geometry[formContainerAnchor].minX, y: geometry[formContainerAnchor].minY)

        // Determine the position of the mini map area
        let miniMapPosition = CGPoint(x: geometry[miniMapAreaAnchor].minX, y: geometry[miniMapAreaAnchor].minY)

        // -------------------------------------------------------------------------------------------------
        // iOS 13 Beta 5 Release Notes. Known Issues:
        // Using a ForEach view with a complex expression in its closure can may result in compiler errors.
        // Workaround: Extract those expressions into their own View types. (53325810)
        // -------------------------------------------------------------------------------------------------
        // The following view had to be encapsulated in two separate functions (miniMapView & rectangleView),
        // because beta 5 has a bug that fails to compile expressions that are "too complex".
        return AnyView(miniMapView(factor, containerPosition, miniMapPosition, titleSize))
    }

    func miniMapView(_ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint, _ titleSize: CGSize) -> some View {
        ZStack(alignment: .topLeading) {
            
            // Create a small representation of each of the form's views.
            // Preferences are traversed in reverse order, otherwise the branch views
            // would be covered by their ancestors
            ForEach(preferences.reversed()) { pref in
                
                if (pref.vtype == .field(4)) {
                    let _ = print("debug0000 ===========================================")
                    let _ = print("debug0000 vtype : \(pref.vtype)")
                    let _ = print("debug0000 vtype : \(pref.getColor())")
                    let _ = print("debug0000 origin : \(self.geometry[pref.bounds].origin)")
                    let _ = print("debug0000 bounds : \(self.geometry[pref.bounds])")
                    let _ = print("debug0000 -------------------------------------------")
                    let _ = print("debug0000 minX : \(self.geometry[pref.bounds].minX)")
                    let _ = print("debug0000 containerPosition.x) : \(containerPosition.x)")
                    let _ = print("debug0000 factor : \(factor)")
                    let _ = print("debug0000 miniMapPosition.x, : \(miniMapPosition.x)")

                    let _ = print("debug0000 minY : \(self.geometry[pref.bounds].minY)")
                    let _ = print("debug0000 containerPosition.y) : \(containerPosition.y)")
                    let _ = print("debug0000 factor : \(factor)")
                    let _ = print("debug0000 miniMapPosition.y, : \(miniMapPosition.y)")
                }

                if pref.show() { // some type of views, we don't want to show
                    switch pref.vtype {
                    case .title:
                        self.titleMapRectangleView(pref, factor, containerPosition, miniMapPosition)
                    case .twitterfield(let amount):
                        self.twitterMapRectangleView(pref, factor, containerPosition, miniMapPosition, titleSize)
                    case .twitterFieldContainer:
                        self.twitterMapRectangleView(pref, factor, containerPosition, miniMapPosition, titleSize)
                    default:
                        self.rectangleView(pref, factor, containerPosition, miniMapPosition, titleSize)
                    }
                }
            }
        }.padding(5)
    }
    
    func rectangleView(_ pref: MyPreferenceData, _ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint, _ titleSize: CGSize) -> some View {
        Rectangle()
        .fill(pref.getColor())
        .frame(width: self.geometry[pref.bounds].size.width / factor,
               height: self.geometry[pref.bounds].size.height / factor)
        .offset(x: (self.geometry[pref.bounds].minX - containerPosition.x) / factor + miniMapPosition.x,
                y: (self.geometry[pref.bounds].minY - containerPosition.y) / factor + miniMapPosition.y - titleSize.height * 2)
    }
}

private extension MiniMap {
    
    // Mapの中のTitleパーツ用
    func titleMapRectangleView(_ pref: MyPreferenceData, _ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint) -> some View {
        Rectangle()
        .fill(pref.getColor())
        .frame(width: self.geometry[pref.bounds].size.width / factor,
               height: self.geometry[pref.bounds].size.height / factor)
        .offset(x: (self.geometry[pref.bounds].minX - containerPosition.x) / factor + miniMapPosition.x,
                y: (self.geometry[pref.bounds].minY - containerPosition.y) / factor + miniMapPosition.y)
    }
    
    // Mapの中のTwitterパーツ用
    func twitterMapRectangleView(_ pref: MyPreferenceData, _ factor: CGFloat, _ twitterContainerPosition: CGPoint, _ miniMapPosition: CGPoint, _ titleSize: CGSize) -> some View {
        Rectangle()
        .fill(pref.getColor())
        .frame(width: self.geometry[pref.bounds].size.width / factor,
               height: self.geometry[pref.bounds].size.height / factor)
        .offset(x: (self.geometry[pref.bounds].minX - twitterContainerPosition.x) / factor + miniMapPosition.x,
                y: (self.geometry[pref.bounds].minY - twitterContainerPosition.y) / factor + miniMapPosition.y - titleSize.height * 2)
        .opacity(self.twitterFieldPreset ? 1 : 0)
    }

}

struct NestedViewPreferenceSample_Previews: PreviewProvider {
    static var previews: some View {
        NestedViewPreferenceSample()
    }
}
