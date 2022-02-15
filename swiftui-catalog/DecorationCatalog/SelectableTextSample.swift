//
//  SelectableTextSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/15.
//

import SwiftUI

enum Action: String, CaseIterable, Identifiable {
    case create
    case edit
    case delete
    case duplicate
    
    var id: String { rawValue }
}

struct SelectableTextSample: View {
    var body: some View {
        List {
            ForEach(Action.allCases) { action in
                Button(action: {
                    print("debug0000 \(action.id)")
                }) {
                    Text(action.id)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct SelectableTextSample_Previews: PreviewProvider {
    static var previews: some View {
        SelectableTextSample()
    }
}
