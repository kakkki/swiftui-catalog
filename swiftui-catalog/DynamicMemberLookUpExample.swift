//
//  DynamicMemberLookUpExample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/19.
//

import SwiftUI


struct DynamicMemberLookUpExample: View {
    @dynamicMemberLookup
    struct Lens<T> {
        var value: T
        subscript<U>(dynamicMember keyPath: WritableKeyPath<T, U>) -> U {
            return value[keyPath: keyPath]
        }
    }

    private struct SamplePoint {
      var x, y: Double
    }

    private struct SampleRectangle {
      var topLeft, bottomRight: SamplePoint
    }

    @State var topLeftX: Double = 0.0
    @State var topLeftY: Double = 0.0
    
    var body: some View {
        VStack {
            Button(action: {
                updateLens()
            }) {
                Text("Update Lens")
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    }
            }
            Text("topLeftX: \(topLeftX)")
            Text("topLeftY: \(topLeftY)")
        }
    }
    
    func updateLens() {
        let topLeft = SamplePoint(x: 10, y: 15)
        let bottomRight = SamplePoint(x: 20, y: 20)
        let rect = SampleRectangle(topLeft: topLeft, bottomRight: bottomRight)
        let lensRectangle = Lens(value: rect)
        
        // keypath + @dynamicMemberLookup によって直接メンバでない変数をdot syntaxで参照できてる
        topLeftX = lensRectangle.topLeft.x
        topLeftY = lensRectangle.topLeft.y
        print(lensRectangle.topLeft)
        print(lensRectangle.bottomRight)

    }
}

struct DynamicMemberLookUpExample_Previews: PreviewProvider {
    static var previews: some View {
        DynamicMemberLookUpExample()
    }
}
