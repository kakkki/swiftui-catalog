//
//  Rotation3DEffectTab.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/08.
//

import SwiftUI

struct Rotation3DEffectTab: View {
    var body: some View {
        TabView {
            ForEach(sampleCourses) { course in
                GeometryReader { proxy in
                    FeaturedItem(course: course)
                        .cornerRadius(30)
                        .rotation3DEffect(
                            .degrees(proxy.frame(in: .global).minX / -10),
                            axis: (x: 0, y: 1, z: 0), perspective: 1
                        )
                        .shadow(color: Color("Shadow").opacity(0.3),
                                radius: 30, x: 0, y: 30)
                        .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
                        // overlayの画像は回転させたくないので
                        // FeaturedItemの外に出して、rotation3DEffectより前にコールされるようにしてる
                        .overlay(
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(x: 32, y: -80)
                                .frame(height: 230)
                                .offset(x: proxy.frame(in: .global).minX / 2)
                        )
                        .padding(20)
                                    
                    
                    Text("proxy.frame(in: .global).minX : \(proxy.frame(in: .global).minX)")
                        .offset(x: 40, y: 400)
                    // tabを動かしてもlocalスコープでの原点は変わらない。
                    // 変わるのはglobalスコープでの、
                    // ForEach内の各Geometryの原点の位置。
                    Text("proxy.frame(in: .local).minX : \(proxy.frame(in: .local).minX)")
                        .offset(x: 40, y: 450)
                }

            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 500)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -10)
        )
    }
}

struct Rotation3DEffectTab_Previews: PreviewProvider {
    static var previews: some View {
        Rotation3DEffectTab()
    }
}
