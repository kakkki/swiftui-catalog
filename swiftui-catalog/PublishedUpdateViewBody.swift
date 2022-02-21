//
//  PublishedUpdateViewBody.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/18.
//

import SwiftUI


// SwiftUI GUIDEBOOK
// レンダリングシステムの考察とデータの使い分け
struct PublishedUpdateViewBody: View {
    
    private class Group: ObservableObject {
        @Published var id: String
        init(id: String) {
            self.id = id
        }
    }

    @ObservedObject private var object = Group(id: "Group1")
    
    var body: some View {
        let _ = print(#function)
        
        VStack(alignment: .center) {
            Text(object.id)
                
            HStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.width / 2)
                TextField("id", text: $object.id)
            }
            Button(action: {
                self.object.id = UUID().uuidString
            }) {
                Text("Generate UUID")
            }
        }
    }
}

struct PublishedUpdateViewBody_Previews: PreviewProvider {
    static var previews: some View {
        PublishedUpdateViewBody()
    }
}
