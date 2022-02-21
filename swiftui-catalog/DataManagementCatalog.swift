//
//  DataManagementCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/18.
//

import SwiftUI

struct DataManagementCatalog: View {
    var body: some View {
        List(samples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let samples = [
        Sample(title: "UserDefaultsWithTextFieldSample", desinationView: AnyView(UserDefaultsWithTextFieldSample())),
        Sample(title: "UserDefaultWithCombineSample", desinationView: AnyView(UserDefaultWithCombineSample(SettingsStore()))),
        Sample(title: "PublishedUpdateViewBody", desinationView: AnyView(PublishedUpdateViewBody())),
        Sample(title: "KeyPathSample", desinationView: AnyView(KeyPathSample())),
        Sample(title: "PropertyWrapperSample", desinationView: AnyView(PropertyWrapperSample())),
        Sample(title: "SubscriptSample", desinationView: AnyView(SubscriptSample())),
        Sample(title: "SE-0252: DynamicMemberLookUpExample with KeyPath", desinationView: AnyView(DynamicMemberLookUpExample())),
    ]
}

struct DataManagementCatalog_Previews: PreviewProvider {
    static var previews: some View {
        DataManagementCatalog()
    }
}
