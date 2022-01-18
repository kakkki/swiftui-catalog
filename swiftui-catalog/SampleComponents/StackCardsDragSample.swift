//
//  StackCardsDragSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/18.
//

import SwiftUI

struct StackCardsDragSample: View {
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
                .frame(height: 100)
                .foregroundColor(.clear)

            Spacer()

            ZStack {
                DraggableCardOnTap(
                    show: $show,
                    text: "Hello3",
                    color: Color("card2"),
                    scale: 0.85,
                    heightOffsetOnHide: -80,
                    heightOffsetOnShow: -420
                )
                
                DraggableCardOnTap(
                    show: $show,
                    text: "Hello2",
                    color: Color("card4"),
                    scale: 0.9,
                    heightOffsetOnHide: -40,
                    heightOffsetOnShow: -200
                )

                DraggableCardOnTap(
                    show: $show,
                    text: "Hello1",
                    color: Color("card3"),
                    scale: 0.95,
                    heightOffsetOnHide: 0,
                    heightOffsetOnShow: 0
                )
                .onTapGesture {
                    self.show.toggle()
                }
            }

            Text("StackCardsDragSample")
                .blur(radius: show ? 6 : 0)
        }
    }
}

private struct DraggableCardOnTap : View {
    @Binding var show: Bool
    var text: String
    var color: Color
    var scale: CGFloat
    var heightOffsetOnHide: CGFloat
    var heightOffsetOnShow: CGFloat
    
    @State var translationSize = CGSize.zero
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if (show) {
                    self.translationSize = value.translation
                }
            }
            .onEnded { value in
                if (show) {
                    self.translationSize = .zero
                }
            }
    }

    var body: some View {
        ZStack {
            Text(text)
                .frame(width: 300, height: 180)
                .background(color)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? heightOffsetOnShow : heightOffsetOnHide)
                .scaleEffect(scale)
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5), value: show)
        }
        .offset(x: translationSize.width, y: translationSize.height)
        .gesture(drag)
    }
}

struct StackCardsDragSample_Previews: PreviewProvider {
    static var previews: some View {
        StackCardsDragSample()
    }
}
