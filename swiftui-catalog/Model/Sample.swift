//
//  Sample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/29.
//

import SwiftUI

struct Sample: Identifiable {
    let id = UUID()
    let title: String
    let desinationView: AnyView?
}
