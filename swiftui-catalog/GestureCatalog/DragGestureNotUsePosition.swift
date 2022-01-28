//
//  DragGestureNotUsePosition.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/01/16.
//

import SwiftUI

struct DragGestureNotUsePosition: View {
    @State var translationSize = CGSize.zero
    
    var body: some View {
        VStack(alignment: .leading) {
            let _ = print("debug0000 init translationSize \(translationSize)")
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.pink)
                .frame(width: 100, height: 100)
                .offset(x: translationSize.width, y: translationSize.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translationSize = value.translation
                            print("debug0000 translation \(value.translation)")
                            // そうか
                            // 一度ドラッグを終わらしてからまたドラッグすると
                            // translationは(0.0, 0.0) に戻っちゃうんだ
                        }
                        .onEnded { value in
                            self.translationSize = .zero
                        }
                )
            Text("どこから描画される?")
            Text("DragGestureのTranslationは、非連続なドラッグを跨げない")
            Text("なのでドラッグが終わったらzeroに戻してる")
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct DragGestureNotUsePosition_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureNotUsePosition()
    }
}
