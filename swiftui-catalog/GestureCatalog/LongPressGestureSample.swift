//
//  LongPressGestureSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct LongPressGestureSample: View {
    @GestureState var isDetectingLongPress = false
    
    var body: some View {
        let press = LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
        
        return Circle()
            .fill(isDetectingLongPress ? Color.yellow : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(press)
    }

}

struct LongPressGestureSample_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureSample()
    }
}
