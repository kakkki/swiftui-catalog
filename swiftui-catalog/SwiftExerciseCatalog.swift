//
//  SwiftExerciseCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/21.
//

import SwiftUI

struct SwiftExerciseCatalog: View {
    var body: some View {
        List(samples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let samples = [
        Sample(title: "EscapingSamples", desinationView: AnyView(EscapingSamples())),
    ]
}

struct SwiftExerciseCatalog_Previews: PreviewProvider {
    static var previews: some View {
        SwiftExerciseCatalog()
    }
}
