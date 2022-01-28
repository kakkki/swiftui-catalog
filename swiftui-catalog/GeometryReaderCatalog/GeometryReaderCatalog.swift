//
//  GeometryReaderCatalog.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/28.
//

import SwiftUI

struct GeometryReaderCatalog: View {
    var body: some View {
        List(geometryReaderSamples) { sample in
            NavigationLink(sample.title, destination: sample.desinationView)
        }
    }

    let geometryReaderSamples = [
        Sample(title: "SyncColumnWidthSample", desinationView: AnyView(SyncColumnWidthSample())),
        Sample(title: "GeometryPreferenceSample", desinationView: AnyView(GeometryPreferenceSample())),
        Sample(title: "AnchorPreferenceSample", desinationView: AnyView(AnchorPreferenceSample())),
        Sample(title: "NestedViewPreferenceSample", desinationView: AnyView(NestedViewPreferenceSample())),
        Sample(title: "SetPositionToCenterExample", desinationView: AnyView(SetPositionToCenterExample())),
        Sample(title: "PositionChangeExample", desinationView: AnyView(PositionChangeExample())),
        Sample(title: "TrackableScrollViewSample todo implement", desinationView: AnyView(TrackableScrollViewSample())),
    ]
}

struct GeometryReaderCatalog_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderCatalog()
    }
}
