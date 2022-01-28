//
//  OverlayViewSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/17.
//

import SwiftUI

struct OverlayViewSample: View {
    var body: some View {
        // @see https://developer.apple.com/documentation/swiftui/view/overlay(alignment:content:)
        Image(systemName: "folder")
            .font(.system(size: 55, weight: .thin))
            .overlay(alignment: .bottom) {
                Text("❤️")
            }
    }
}

struct OverlayViewSample_Previews: PreviewProvider {
    static var previews: some View {
        OverlayViewSample()
    }
}
