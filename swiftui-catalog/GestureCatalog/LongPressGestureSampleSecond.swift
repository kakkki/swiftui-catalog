//
//  LongPressGestureSampleSecond.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/26.
//

import SwiftUI

struct LongPressGestureSampleSecond: View {
    @GestureState var isDetectingLongPress = false
    @State var totalNumberOfTaps = 0
    
    var body: some View {
        let press = LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }.onChanged { _ in
                self.totalNumberOfTaps += 1
            }
        
        return VStack {
            Text("\(totalNumberOfTaps)")
                .font(.largeTitle)
            
            Circle()
                .fill(isDetectingLongPress ? Color.yellow : Color.green)
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(press)
        }
    }
}

struct LongPressGestureSampleSecond_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureSampleSecond()
    }
}
