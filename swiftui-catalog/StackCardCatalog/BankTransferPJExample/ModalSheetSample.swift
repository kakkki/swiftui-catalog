//
//  ModalSheetSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2023/07/20.
//

import SwiftUI

struct Constants {
    static let ColorPrimaryBlue: Color = Color(red: 0, green: 0.72, blue: 0.76)
}

struct ModalSheetSample: View {
        
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
          
            HStack(alignment: .center, spacing: 0) {
                Text("口座自動引き落としお申し込み")
                  .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                  .frame(maxWidth: .infinity, alignment: .top)
                
                ZStack {
                    Image("icon/close/normal")
                    .frame(width: 10, height: 10)
                    
                    Image("Oval")
                    .frame(width: 24, height: 24)
                    .background(Color(red: 0.46, green: 0.46, blue: 0.5).opacity(0.12))
                }
                .frame(width: 24, height: 24)
            }
            .padding(.leading, 24)
            .padding(.trailing, 0)
            .padding(.vertical, 0)
            .frame(maxWidth: .infinity, alignment: .center)
            
            // Border Line
            Image("Line Copy")
                .frame(maxWidth: .infinity, minHeight: 0.1, maxHeight: 0.1)
            .overlay(
              Rectangle()
                .stroke(Color(red: 0.93, green: 0.94, blue: 0.94), lineWidth: 1)
            )
            .padding(.horizontal, -100)
            
            // 次回お引き落とし予定
            VStack(alignment: .center, spacing: 16) {
                Image("icon_Calendar")
                    .frame(width: 34, height: 34)

                Text("次回お引き落とし予定")
                  .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                  .frame(maxWidth: .infinity, alignment: .top)

                Text("10月27日")
                  .font(
                    Font.custom("SF Pro", size: 19)
                      .weight(.semibold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                  .frame(maxWidth: .infinity, alignment: .top)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.25)
                    .stroke(Color(red: 0, green: 0.72, blue: 0.76), lineWidth: 0.5)
            )
            
            // 翌月のお支払いから変更されます
            VStack(alignment: .leading, spacing: 16) {
                Text("翌月のお支払いから変更されます")
                  .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                  .frame(maxWidth: .infinity, alignment: .top)
                Text("すでに請求が確定している場合は\nコンビニでお支払いします")
                  .font(Font.custom("Hiragino Kaku Gothic Pro", size: 12))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                  .frame(maxWidth: .infinity, alignment: .top)
                     
             }
            .padding(0)
            .frame(width: 326, alignment: .topLeading)
            
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center, spacing: 8) {
                    // JP/iOS/Paragraph/MediumBold
                    Text("同意して申し込む")
                      .font(Font.custom("Hiragino Kaku Gothic Pro", size: 15))
                      .multilineTextAlignment(.center)
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .center)
                    
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Constants.ColorPrimaryBlue)
                .cornerRadius(4)

                HStack(alignment: .center, spacing: 8) {
                    // JP/iOS/Paragraph/MediumBold
                    Text("やめる")
                      .font(Font.custom("Hiragino Kaku Gothic Pro", size: 15))
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color(red: 0.59, green: 0.63, blue: 0.69))
                      .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .center)
                    
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(4)

            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(32)
        .frame(maxWidth: .infinity, alignment: .top)
        
        

    }
}

struct ModalSheetSample_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetSample()
    }
}
