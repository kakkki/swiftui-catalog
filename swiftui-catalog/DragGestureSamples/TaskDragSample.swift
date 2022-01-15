//
//  TaskDragSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/15.
//

import SwiftUI

struct TaskDragSample: View {
    
    var body: some View {
//        Sample1()
        Sample2()
    }
}

private struct Sample1: View {
    private let screenWidthCenter = UIScreen.main.bounds.size.width / 2
    private let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack() {
            Rectangle()
                .frame(height: 500)
                .foregroundColor(Color("card2"))
                .opacity(0.3)
                .cornerRadius(20)
                .shadow(radius: 20)
                .blendMode(.hardLight)
                .position(x: screenWidthCenter, y: 250)


            // @see https://stackoverflow.com/questions/61493788/how-to-position-views-relative-to-their-top-left-corner-in-swiftui
            // 画面上下にコンテンツを詰めるのに必要
            Spacer()

            // ScrollViewだとカードをドラッグした時に
            // 上のRectangleの下にカードが隠れてしまう
//                ScrollView(.horizontal) {
//                    HStack {
//                        SampleCardsRow()
//                        SampleCardsRow()
//                    }
//                }
            TabView {
                SampleCardsRow()
                SampleCardsRow()
            }
            .offset(y: 520)
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct Sample2: View {
        
    private let screenWidthCenter = UIScreen.main.bounds.size.width / 2
    private let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack() {
            Rectangle()
                .frame(height: 500)
                .foregroundColor(Color("card2"))
                .opacity(0.3)
                .cornerRadius(20)
                .shadow(radius: 20)
                .blendMode(.hardLight)
                .position(x: screenWidthCenter, y: 250)
                


            // @see https://stackoverflow.com/questions/61493788/how-to-position-views-relative-to-their-top-left-corner-in-swiftui
            // 画面上下にコンテンツを詰めるのに必要
            Spacer()

            
            
            SampleCard()
                .padding(.top, 10)
                .offset(x: 0 + 10, y: 500)

            SampleCard()
                .padding(.top, 10)
                .offset(x: 200 + 10 + 10, y: 500)

            SampleCard()
                .padding(.top, 20)
                .offset(x: 0 + 10, y: 600)

            SampleCard()
                .padding(.top, 20)
                .offset(x: 200 + 10 + 10, y: 600)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SampleCard: View {

    @State var position = CGSize(width: 100, height: 50)

    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
    }

    var body: some View {
        Text("シャンプー買う")
            .foregroundColor(.white)
            .font(.headline)
            .frame(width: 200, height: 100)
            .background(Color("card4"))
            .cornerRadius(20)
            .shadow(radius: 20)
            .aspectRatio(1, contentMode: .fit)
            .blendMode(.hardLight)
            .position(x: self.position.width, y: self.position.height)
            .gesture(drag)
    }
}

private struct SampleCardsRow: View {
    var body: some View {
        VStack {
            HStack {
                SampleCard()
                SampleCard()
            }
        }
    }
}

struct TaskDragSample_Previews: PreviewProvider {
    static var previews: some View {
        TaskDragSample()
    }
}
