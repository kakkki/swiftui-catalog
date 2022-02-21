//
//  PropertyWrapperSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/19.
//

import SwiftUI
import Combine

@propertyWrapper struct Trimmed0 {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set {
            value = newValue.trimmingCharacters(in: .whitespaces)
        }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct PropertyWrapperSample: View {
    
    struct Post0 {
        @Trimmed0 var title: String
    }

    var post0 = Post0(title: "     init      ")
    
    var body: some View {
        Text("post0: \(post0.title)")
    }
}

struct PropertyWrapperSample_Previews: PreviewProvider {
    static var previews: some View {
        PropertyWrapperSample()
    }
}
