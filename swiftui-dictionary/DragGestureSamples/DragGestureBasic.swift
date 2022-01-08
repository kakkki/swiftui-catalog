//
//  DragGestureBasic.swift
//  swiftui-dictionary
//
//  Created by Atsuki Kakehi on 2022/01/08.
//

import SwiftUI

struct DragGestureBasic: View {
    @State var position = CGSize(width: 200, height: 300)
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
    }
    
    var body: some View {
        ZStack {
            Text("Image Center x: \(position.width)")
                .position(x: 200, y: 100)
            Text("Image Center y: \(position.height)")
                .position(x: 200, y: 125)
            Image("Illustration 5")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 230)
            // Positions the center of this view at the specified coordinates in its parent’s coordinate space.
                .position(x: position.width, y: position.height)
                .gesture(drag)
            
        }
    }
}

struct BasicSample_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBasic()
    }
}
