//
//  VStackSpacerLayoutSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/18.
//

import SwiftUI

struct VStackSpacerLayoutSample: View {
    var body: some View {
        
        VStack {
            Text("sample")
                .frame(width: 340, height: 200)
                .background(Color("card2"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .scaleEffect(0.95)

            Text("↓はSpacerでheight:150指定して間を空けてる")
            
            Spacer()
                .frame(height: 150)

            ZStack {
                Text("sample")
                    .frame(width: 340, height: 200)
                    .background(Color("card2"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0, y: -80)
                    .scaleEffect(0.85)
                    .offset(x: 0, y: 0)
                    .blendMode(.hardLight)

                Text("Hello2")
                    .frame(width: 340, height: 220)
                    .background(Color("card4"))
                    .opacity(0.5)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0, y: -40)
                    .scaleEffect(0.9)
                    .blendMode(.hardLight)

                Text("Hello1")
                    .frame(width: 340, height: 220)
                    .background(Color("card3"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .scaleEffect(0.95)
                    .blendMode(.hardLight)
            }
            
            Spacer()

            Text("↑はSpacerで間を空けてる")
        }
    }
}

struct VStackSpacerLayoutSample_Previews: PreviewProvider {
    static var previews: some View {
        VStackSpacerLayoutSample()
    }
}
