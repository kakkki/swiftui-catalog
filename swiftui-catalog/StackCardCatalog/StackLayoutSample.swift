//
//  StackLayoutSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/12.
//

import SwiftUI

struct StackLayoutSample: View {
    var body: some View {
        ZStack {
            // どっちでも同じレイアウト
//            VStack {
//                Spacer()
//            }
            Spacer()
            .frame(width: 300, height: 220)
            .background(Color.blue)
            .cornerRadius(20)
            .shadow(radius: 20)
            .offset(x: 0, y: -20)

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("UI Design")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("Certificate")
                            .foregroundColor(Color("accent"))
                    }
                    Spacer()
                    Image("Logo1")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                Spacer()
                Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 110, alignment: .top)

            }
            .frame(width: 340.0, height: 220.0)
            .background(.black)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

struct StackLayoutSample_Previews: PreviewProvider {
    static var previews: some View {
        StackLayoutSample()
    }
}
