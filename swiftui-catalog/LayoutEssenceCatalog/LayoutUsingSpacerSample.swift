//
//  LayoutUsingSpacerSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/16.
//

import SwiftUI

struct LayoutUsingSpacerSample: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Top Text")
                    .font(.system(size: 20))
                    .fontWeight(.medium)

                Text("Bottom Text")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                Spacer()
            }
            Spacer()
        }
    }
}

struct LayoutUsingSpacerSample_Previews: PreviewProvider {
    static var previews: some View {
        LayoutUsingSpacerSample()
    }
}
