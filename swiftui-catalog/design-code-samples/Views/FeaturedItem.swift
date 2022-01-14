//
//  FeaturedItem.swift
//  swiftui-catalog
//
//  Created by 筧敦気 on 2022/01/06.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course = sampleCourses[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Image(course.logo)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(10)
                .padding(9)
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: 16, style: .continuous)
                )
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .lineLimit(1)
            Text(course.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text(course.text)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        
        // overlay画像やshadowは回転させたくないので、FearturedItemの外に出した
//        .padding(.all, 20.0)
//        .padding(.vertical, 20)
//        .frame(height: 350.0)
//        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
//        .padding(.horizontal, 20)
//        .overlay(
//            Image(course.image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 230)
//                .offset(x: 32, y: -80)
//        )
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem()
    }
}
