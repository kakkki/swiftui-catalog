//
//  CVSPaymentMethodInfoCell.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2023/07/20.
//

import SwiftUI

struct CVSPaymentMethodInfoCell: View {
    var body: some View {
        
        ZStack {
            // 上・Border Line・下を格納するコンテナ
            // 支払い方法
            VStack(spacing: 16) {

                // Border Lineより上のコンテナ
                // Frame 624639
                VStack(spacing: 10) {
                    // Frame 624598
                    HStack(alignment: .center, spacing: 16) {
                        Text("コンビニ支払い")
                          .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                          .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        // 利用中
                        HStack(alignment: .center, spacing: 4) {
                            // チェックアイコン
                            Image("icon_Check")
                                .frame(width: 7, height: 7)
                                .padding(2)
                                .background(Color(red: 0, green: 0.72, blue: 0.76))
                                .cornerRadius(30)
                            
                            Text("利用中")
                                .font(Font.custom("Hiragino Kaku Gothic Pro", size: 12))
                                .foregroundColor(Color(red: 0, green: 0.72, blue: 0.76))
                        }
                        .padding(8)
                        .background(Color(red: 0.81, green: 0.94, blue: 0.92))
                        .cornerRadius(4)
                    }
                    
                    Text("毎月10日までに、コンビニの店頭でお支払いします。")
                      .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                      .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                      .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Divider
                Rectangle()
                    .fill(Color(red: 0.93, green: 0.94, blue: 0.94))
                    .frame(height: 1.0)
                    .edgesIgnoringSafeArea(.horizontal)

                
                // Frame 624599
                VStack(alignment: .leading, spacing: 6) {
                    // Frame 624598
                    HStack(alignment: .top, spacing: 16) {
                        Text("お支払い期限")
                          .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                          .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text("毎月1日 - 10日")
                          .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                          .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                    }
                    
                    HStack(alignment: .top, spacing: 16) {
                        Text("手数料")
                          .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                          .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text("350円")
                          .font(Font.custom("SF Pro", size: 15).weight(.bold))
                          .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                    }
                }
            }
            .padding(24)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 0, green: 0.72, blue: 0.76), lineWidth: 2)
            )
        }
        // これがあることでコンテナを.frame(width: 358, alignment: .top)しなくてよくなった
        .padding(24)
    }
}

struct CVSPaymentMethodInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        CVSPaymentMethodInfoCell()
    }
}
