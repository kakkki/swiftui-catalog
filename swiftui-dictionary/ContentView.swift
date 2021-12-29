//
//  ContentView.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2021/12/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            List(samples) { sample in
                NavigationLink(sample.title, destination: SyncColumnWidthSample())

            }
            VStack {
                
                NavigationLink("link1", destination: SyncColumnWidthSample())
                Text("sample2")
            }
        }
    }
}

struct Sample: Identifiable {
    let id = UUID()
    let title: String
    let desinationView: AnyView
}

let samples:[Sample] = [
    Sample(title: "SyncColumnWidthSample", desinationView: AnyView(SyncColumnWidthSample())),
    Sample(title: "sample2", desinationView: AnyView(SyncColumnWidthSample()))
]



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
