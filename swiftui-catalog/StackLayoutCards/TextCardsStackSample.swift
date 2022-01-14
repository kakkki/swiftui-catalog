//
//  TextCardsStackSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/14.
//

import SwiftUI

struct TextCardsStackSample: View {

    @State private var show = false

    var body: some View {
        
        VStack {
            
            Text("sample")
                .frame(width: 340, height: 200)
                .background(Color("card2"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .scaleEffect(0.95)
                .offset(x: 0, y: 0)
            
            Rectangle()
                .frame(width: .infinity, height: 40)
                .foregroundColor(.clear)


            ZStack {
                Text("sample")
                    .frame(width: 340, height: 200)
                    .background(Color("card2"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0, y: show ? -350 : -200)
                    .scaleEffect(0.85)
                    .rotationEffect(Angle.degrees(show ? 20 : 15))
                    .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))
                    .offset(x: 0, y: 0)
                    .blendMode(.hardLight)
                    .animation(.easeInOut(duration: 0.5), value: show)
                

                Text("Hello2")
                    .frame(width: 340, height: 220)
                    .background(Color("card4"))
                    .opacity(0.5)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0, y: show ? -200 : -100)
                    .scaleEffect(0.9)
                    .rotationEffect(Angle.degrees(show ? 15 : 10))
                    .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))
                    .blendMode(.hardLight)
                    .animation(.easeInOut(duration: 0.5), value: show)


                Text("Hello1")
                    .frame(width: 340, height: 220)
                    .background(Color("card3"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0, y: -20)
                    .scaleEffect(0.95)
                    .rotationEffect(Angle.degrees(5))
                    .rotation3DEffect(Angle(degrees: 5), axis: (x: 10.0, y: 0, z: 0))
                    .blendMode(.hardLight)
                    .onTapGesture {
                        self.show.toggle()
                    }
            }
            .offset(x: 0, y: 100)

        }
        

    }
}

struct TextCardsStackSample_Previews: PreviewProvider {
    static var previews: some View {
        TextCardsStackSample()
    }
}
