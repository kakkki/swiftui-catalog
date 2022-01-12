//
//  LeaningStackSample.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/12.
//

import SwiftUI

struct LeaningStackSample: View {
    var body: some View {
        ZStack {
            Spacer()
                .frame(width: 340, height: 220)
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -40)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(10))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
            Spacer()
                .frame(width: 340, height: 220)
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -20)
                .scaleEffect(0.95)
                .rotationEffect(Angle.degrees(5))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
        }

    }
}

struct LeaningStackSample_Previews: PreviewProvider {
    static var previews: some View {
        LeaningStackSample()
    }
}
