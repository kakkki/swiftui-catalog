//
//  EditableListSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/15.
//

import SwiftUI

struct EditableListSample: View {
    @State private var fruits = ["Apple", "Banana", "Mango"]
    @State private var isEditable = false

    var body: some View {
        List {
            ForEach(fruits, id: \.self) { user in
                Text(user)
            }
            .onMove(perform: move)
            .onLongPressGesture {
                withAnimation {
                    self.isEditable = true
                }
            }
        }
        .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
    }

    func move(from source: IndexSet, to destination: Int) {
        fruits.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditable = false
        }
    }
}

struct EditableListSample_Previews: PreviewProvider {
    static var previews: some View {
        EditableListSample()
    }
}
