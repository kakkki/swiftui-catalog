//
//  StackCardsAnimationAndDragGestureSample.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/12.
//

import SwiftUI

struct StackCardsAnimationAndDragGestureSample: View {

    @State var viewState = CGSize.zero
    @State var show = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 6 : 0)
                .animation(.default, value: show)

            Spacer()
                .frame(width: 340, height: 220)
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5), value: show)

            Spacer()
                .frame(width: 340, height: 220)
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5), value: show)

            FrontCardView()
                .offset(x: viewState.width, y: viewState.height)
                .blendMode(.hardLight)
                .onTapGesture {
                    show.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded { value in
                            self.viewState = .zero
                            self.show = false
                        }   
                )
        }
    }
}

struct StackCardsAnimationAndDragGestureSample_Previews: PreviewProvider {
    static var previews: some View {
        StackCardsAnimationAndDragGestureSample()
    }
}
