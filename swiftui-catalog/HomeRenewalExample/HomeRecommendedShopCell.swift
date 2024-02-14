//
//  HomeRecommendedShopCell.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2024/02/05.
//

import SwiftUI
import UIKit

// TODO: レイアウト計算 by CompositionalLayout

// width全体: 390
// widthカード: 208
struct HomeRecommendedShopView: View {
    
    private let logoURL = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/53527ded397ef227854b3bfb78a3b490.jpg")!
    
//    private let url1 = URL(string: "https://base-ec2if.akamaized.net/c/w=585,h=585,a=0,u=0,f=webp/images/item/origin/a2472f9d975a62149a331a82a392b1c3.jpg")!

    // 読み込めない画像
    private let url1 = URL(string: "https://base-ec2if.akamaized.net/c/w=585,h=585,a=0,u=0,f=webp/images/item/origin/2472f9d975a62149a331a82a392b1c3.jpg")!

    private let url2 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/47f79aecfa559597b0e39127d7db3a6a.jpg")!

    // みかん
    let url3 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/9ab0c20ba950ed001ec2c926d1466df8.jpg")!
    // しまのみかん
    let url4 = URL(string: "https://base-ec2if.akamaized.net/c/w=288,h=288,a=0,u=0,f=webp/images/user/logo/c7dbb7519f6c931a62613f95e8160112.jpeg")!


    private let url5 = URL(string: "https://base-ec2if.akamaized.net/images/item/origin/c6226f70eb734e0bed220065ba8f4757.png")!

    private let url6 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/55d9562bb97b06b6c02af80dbfa48719.jpg")!
    

    var body: some View {
        GeometryReader { bodyView in
            VStack(spacing: 0) {
                ZStack {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ItemImageView(
                                bodyViewSize: .init(
                                    width: bodyView.size.width / 2,
                                    height: bodyView.size.height / 2
                                ),
                                url: url1
                            )

                            ItemImageView(
                                bodyViewSize: .init(
                                    width: bodyView.size.width / 2,
                                    height: bodyView.size.height / 2
                                ),
                                url: url2
                            )

                        }
                        HStack(spacing: 0) {
                            ItemImageView(
                                bodyViewSize: .init(
                                    width: bodyView.size.width / 2,
                                    height: bodyView.size.height / 2
                                ),
                                url: url3
                            )
                            ItemImageView(
                                bodyViewSize: .init(
                                    width: bodyView.size.width / 2,
                                    height: bodyView.size.height / 2
                                ),
                                url: url4
                            )
                        }
                    }
                    // 4つの画像の中心にショップロゴを配置する
                    ShopLogoImage(url: logoURL)
                        .cornerRadius(60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(.white, lineWidth: 1)
                        )
                }
                
                
                HomeRecommendedShopTitleView(
                    isFollow: true,
                    bodyViewSize: bodyView.size,
                    url1: url1,
                    url2: url2,
                    url3: url3,
                    url4: url4
                )
                    .frame(width: .infinity)
                
            }
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.25)
                    .stroke(Color(red: 0.93, green: 0.94, blue: 0.94), lineWidth: 0.5)
            )
        }
    }
    
    struct HomeRecommendedShopTitleView: View {
        
        @StateObject var loader = ImageAverageColorLoader()
        
        var isFollow: Bool
        let bodyViewSize: CGSize

        let url1: URL
        let url2: URL
        let url3: URL
        let url4: URL

        init(isFollow: Bool, bodyViewSize: CGSize, url1: URL, url2: URL, url3: URL, url4: URL) {
            self.isFollow = isFollow
            self.bodyViewSize = bodyViewSize
            self.url1 = url1
            self.url2 = url2
            self.url3 = url3
            self.url4 = url4
        }
        
        var body: some View {
            Group {
                switch loader.requestStatus {
                case .blank:
                    Spacer()
                        .onAppear {
                            Task {
                                await loader.loadFourImages(url1: url1, url2: url2, url3: url3, url4: url4)
                            }
                        }
                case .success:
                    if let averageColor = loader.averageColor {
                        TitleView(isFollow: isFollow, bodyViewSize: bodyViewSize)
                            .background(Color(averageColor))
                    } else {
                        // TODO: averageColorがnilだったときのハンドリング
                        /// デフォルトの背景色があれば手っ取り早い
                        Spacer()
                    }
                case .failed:
                    TitleView(isFollow: isFollow, bodyViewSize: bodyViewSize)
                }
            }
        }
        
        struct TitleView: View {
            var isFollow: Bool
            let bodyViewSize: CGSize

            var body: some View {
                HStack(alignment: .center, spacing: 0) {
                    Text("無農薬ジュースとジャム 田中農園のショップ")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.leading, 12)
                    
                    Spacer()

                    // TODO: コンポーネント化したい
                    Button(isFollow ? "フォロー中" : "フォロー") {}
                    .font(.system(size: 12, weight: .bold))
                    .padding(8)
                    .foregroundColor(isFollow ? .white : Color(red: 0.27, green: 0.27, blue: 0.27))
                    .background(isFollow ? .white.opacity(0) : .white.opacity(1))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    )
                    .padding(.trailing, 12)
                }
                .padding(.vertical, 12)
                .frame(width: bodyViewSize.width)
                .background(.black.opacity(0.2))
            }
        }
    }
    
    struct ItemImageView: View {
        let bodyViewSize: CGSize
        let url: URL
        
        var body: some View {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Spacer()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: min(bodyViewSize.width, bodyViewSize.height), height: min(bodyViewSize.width, bodyViewSize.height)) // 幅と高さの小さい方に合わせて正方形を作る
                        .clipped()
                case .failure:
                    Image(.no)
                        .resizable()
                        .scaledToFill()
                        .frame(width: min(bodyViewSize.width, bodyViewSize.height), height: min(bodyViewSize.width, bodyViewSize.height)) // 幅と高さの小さい方に合わせて正方形を作る
                        .clipped()

                @unknown default:
                    Spacer()
                }
            }
        }
    }

    struct ShopLogoImage: View {
        let url: URL

        var body: some View {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Spacer()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 52, height: 52)
                        .clipped()
                case .failure:
                    Spacer()
                @unknown default:
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    VStack {
        HomeRecommendedShopView()
            .frame(width: 208, height: 263)
    }
    .padding(100)
    .background(Color(.systemGray))

}
