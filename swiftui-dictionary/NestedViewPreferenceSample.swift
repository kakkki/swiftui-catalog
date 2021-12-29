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
    @State private var length: Float = 360
    @State private var twitterFieldPreset = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Color(white: 0.7)
                    .frame(width: 200)
                    .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                        return [MyPreferenceData(vtype: .miniMapArea, bounds: $0)]
                    }
                    .padding(.horizontal, 30)
                VStack(alignment: .leading) {
                    VStack {
                        Text("Hello \(fieldValues[0]) \(fieldValues[1]) \(fieldValues[2])")
                            .font(.title).fontWeight(.bold)
                            .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                                return [MyPreferenceData.init(vtype: .title, bounds: $0)]
                        }
                        Divider()
                    }

                    // Switch + Slider
                    HStack {
                        Toggle(isOn: $twitterFieldPreset) { Text("") }
                        Text("twitter")

                        Slider(value: $length, in: 360...540).layoutPriority(1)
                    }.padding(.bottom, 5)

                    // First row of text fields
                    HStack {
                        MyFormField(fieldValue: $fieldValues[0], label: "First Name")
                        MyFormField(fieldValue: $fieldValues[1], label: "Middle Name")
                        MyFormField(fieldValue: $fieldValues[2], label: "Last Name")
                    }.frame(width: 540)
                    
                    // Second row of text fields
                    HStack {
                        MyFormField(fieldValue: $fieldValues[3], label: "Email")
                        
                        if twitterFieldPreset {
                            MyFormField(fieldValue: $fieldValues[4], label: "Twitter")
                        }
                        
                        
                    }.frame(width: CGFloat(length))

                }.transformAnchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                    $0.append(MyPreferenceData(vtype: .formContainer, bounds: $1))
                }
                Spacer()
            }
            .overlayPreferenceValue(MyPreferenceKey.self) { preferences in
                GeometryReader { geometry in
                    MiniMap(geometry: geometry, preferences: preferences)
                }
            }
            
            Spacer()
        }.background(Color(white: 0.8)).edgesIgnoringSafeArea(.all)
    }
}

struct MyFormField: View {
    @Binding var fieldValue: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            TextField("", text: $fieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .anchorPreference(key: MyPreferenceKey.self, value: .bounds) {
                    return [MyPreferenceData(vtype: .field(self.fieldValue.count), bounds: $0)]
                }
        }
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(white: 0.9)))
        .transformAnchorPreference(key: MyPreferenceKey.self, value: .bounds) {
            $0.append(MyPreferenceData(vtype: .fieldContainer, bounds: $1))
        }
    }
}

struct MiniMap: View {
    let geometry: GeometryProxy
    let preferences: [MyPreferenceData]
    
    var body: some View {
        // Get the form container preference
        guard let formContainerAnchor = preferences.first(where: { $0.vtype == .formContainer })?.bounds else { return AnyView(EmptyView()) }
        
        // Get the minimap area container
        guard let miniMapAreaAnchor = preferences.first(where: { $0.vtype == .miniMapArea })?.bounds else { return AnyView(EmptyView()) }
        
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
        return AnyView(miniMapView(factor, containerPosition, miniMapPosition))
    }

    func miniMapView(_ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint) -> some View {
        ZStack(alignment: .topLeading) {
            // Create a small representation of each of the form's views.
            // Preferences are traversed in reverse order, otherwise the branch views
            // would be covered by their ancestors
            
            let _ = print("debug0000 preferences.debugDescription : \(preferences.debugDescription)")
            ForEach(preferences.reversed()) { pref in
                if pref.show() { // some type of views, we don't want to show
                    self.rectangleView(pref, factor, containerPosition, miniMapPosition)
                }
            }
        }.padding(5)
    }
    
    func rectangleView(_ pref: MyPreferenceData, _ factor: CGFloat, _ containerPosition: CGPoint, _ miniMapPosition: CGPoint) -> some View {
        Rectangle()
        .fill(pref.getColor())
        .frame(width: self.geometry[pref.bounds].size.width / factor,
               height: self.geometry[pref.bounds].size.height / factor)
        .offset(x: (self.geometry[pref.bounds].minX - containerPosition.x) / factor + miniMapPosition.x,
                y: (self.geometry[pref.bounds].minY - containerPosition.y) / factor + miniMapPosition.y)
    }

}

struct NestedViewPreferenceSample_Previews: PreviewProvider {
    static var previews: some View {
        NestedViewPreferenceSample()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
