//
//  SubscriptSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/19.
//

import SwiftUI

struct UserNamesSubscript {
    private var userNames: Array<String> = []
    
    subscript(index: Int) -> String? {
        get {
            guard userNames.count != 0, index < userNames.count else { return nil }
            return "Mr. " + userNames[index]
        }
        set(name) {
            userNames.insert(name ?? "Empty Name", at: index)
        }
    }
}

struct SubscriptSample: View {
    
    @State var userNamesSubscript = UserNamesSubscript()
    
    var body: some View {
        
        VStack {
            Button(action: {
                inserUsers()
            }) {
                Text("execute subscript")
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    }
            }
            Text("Member1 : \(userNamesSubscript[0] ?? "")")
            Text("Member2 : \(userNamesSubscript[1] ?? "")")
        }
    }
    
    func inserUsers() {
        userNamesSubscript[0] = "Sorita"
        userNamesSubscript[1] = "Sumino"
    }
}

struct SubscriptSample_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptSample()
    }
}
