//
//  DashedLineSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/09.
//

/**
 https://stackoverflow.com/questions/58526632/swiftui-create-a-single-dashed-line-with-swiftui
 */

import SwiftUI

struct DashedLineSample: View {
    var body: some View {
        VStack {
            Path{ path in
                path.move(to: CGPoint(x: 20, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 300))
            }
            .stroke(style: StrokeStyle( lineWidth: 10, dash: [5]))
            .foregroundColor(Color(UIColor.blue))
        }
    }
}

struct DashedLineSample_Previews: PreviewProvider {
    static var previews: some View {
        DashedLineSample()
    }
}
