//
//  LeaningCard.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/12.
//

import SwiftUI

struct LeaningCardSample: View {
    var body: some View {
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

    }
}

struct LeaningCardSample_Previews: PreviewProvider {
    static var previews: some View {
        LeaningCardSample()
    }
}
