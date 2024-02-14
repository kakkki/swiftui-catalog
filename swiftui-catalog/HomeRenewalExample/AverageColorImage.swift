//
//  AverageColorImage.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2024/02/05.
//

import SwiftUI
import UIKit

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    @Published var averageColor: UIColor?
    
    @Published var imageFailed = false
    
    @Published var errorDescription: String?

    func load(fromURL url: URL) async {
        do {
//            await Task.sleep(2 * 1_000_000_000)

            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let uiImage = UIImage(data: data) {
                self.image = uiImage
                self.averageColor = image?.averageColor()
            } else {
                self.errorDescription = response.description
                self.imageFailed = true
            }
        } catch {
            // エラー処理
            print("画像の読み込み中にエラーが発生しました: \(error)")
            self.imageFailed = true
        }
    }

    func loadTwoImages(fromURL url1: URL, andURL url2: URL) async {
        do {
//            await Task.sleep(2 * 1_000_000_000)
            
            async let (data1, response1) = URLSession.shared.data(from: url1)
            async let (data2, response2) = URLSession.shared.data(from: url2)

            let (imageData1, imageData2) = try await (data1, data2)
            
            if let uiImage1 = UIImage(data: imageData1), let uiImage2 = UIImage(data: imageData2) {
//                self.image = uiImage1
//                self.averageColor = image?.averageColor()
                
                var averageColors: [UIColor] = []
                if let averageColor1 = uiImage1.averageColor() {
                    averageColors.append(averageColor1)
                }
                if let averageColor2 = uiImage2.averageColor() {
                    averageColors.append(averageColor2)
                }

                self.averageColor = averageColor(colors: averageColors)
            } else {
//                self.errorDescription = response1.description
                self.imageFailed = true
            }
        } catch {
            // エラー処理
            print("画像の読み込み中にエラーが発生しました: \(error)")
            self.imageFailed = true
        }
    }

    func loadFourImages(url1: URL, url2: URL, url3: URL, url4: URL) async {
        do {
            async let (data1, response1) = URLSession.shared.data(from: url1)
            async let (data2, response2) = URLSession.shared.data(from: url2)
            async let (data3, response3) = URLSession.shared.data(from: url3)
            async let (data4, response4) = URLSession.shared.data(from: url4)

            let (imageData1, imageData2, imageData3, imageData4) = try await (data1, data2, data3, data4)
            
            var imageColors: [UIColor] = []

            func appendAverageColorFromImage(imageData: Data) {
                if let uiImage = UIImage(data: imageData), let averageColor = uiImage.averageColor() {
                    imageColors.append(averageColor)
                }
            }
            
            appendAverageColorFromImage(imageData: imageData1)
            appendAverageColorFromImage(imageData: imageData2)
            appendAverageColorFromImage(imageData: imageData3)
            appendAverageColorFromImage(imageData: imageData4)
 
            self.averageColor = averageColor(colors: imageColors)
            
        } catch {
            // エラー処理
            print("画像の読み込み中にエラーが発生しました: \(error)")
            self.imageFailed = true
        }
    }

    
    func averageColor(colors: [UIColor]) -> UIColor {
        var totalRed = 0.0
        var totalGreen = 0.0
        var totalBlue = 0.0
        var totalAlpha = 0.0

        for color in colors {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0

            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            totalRed += Double(red)
            totalGreen += Double(green)
            totalBlue += Double(blue)
            totalAlpha += Double(alpha)
        }

        let count = Double(colors.count)
        return UIColor(red: CGFloat(totalRed / count), green: CGFloat(totalGreen / count), blue: CGFloat(totalBlue / count), alpha: CGFloat(totalAlpha / count))
    }
}

struct ImageViewer: View {
    @StateObject var loader = ImageLoader()
    let url: URL

    // TODO: 画像の読み込みPhaseを判定するenumでswitchで制御する
    /// loading(or empty), loaded, failed
    var body: some View {
        Group {
            if let image = loader.image {
                VStack(spacing: 0) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    if let averageColor = image.averageColor() {
                        HStack {
                            Text("ImageViewer11")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height: 32)
                        .padding(12)
                        .background(.black.opacity(0.2))
                        .background(Color(averageColor))

                    }
                }
            } else {
                if loader.imageFailed {
                    HStack {
                        Text(loader.errorDescription!)
                    }
                } else {
//                    ProgressView()
//                        .onAppear {
//                            Task {
//                                await loader.load(fromURL: url)
//                            }
//                        }
                    VStack(spacing: 0) {
                        Image(.background1)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onAppear {
                                Task {
                                    await loader.load(fromURL: url)
                                }
                            }
                        
                        HStack {
                            Text("ImageViewer")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height: 32)
                        .padding(12)
                        .background(.black.opacity(0.2))
//                        .background(.sy)

                    }

                    
                }
            }
        }
    }
}

#Preview {
    // ゾウ
    let url4 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/55d9562bb97b06b6c02af80dbfa48719.jpg")!

    // みかん
    let url5 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/9ab0c20ba950ed001ec2c926d1466df8.jpg")!

    // しまのみかん
    let url6 = URL(string: "https://base-ec2if.akamaized.net/c/w=288,h=288,a=0,u=0,f=webp/images/user/logo/c7dbb7519f6c931a62613f95e8160112.jpeg")!

    let urlNG = URL(string: "https://base-ec2if.akamaized.net/c/w=288,h=288,a=0,u=0,f=webp/images/user/logo/c7dbb7519f6c931a62613f95e8160.jpeg")!

    return VStack {
        Spacer()

        ImageViewer(url: url4)

        ImageViewer(url: url5)
        
        ImageViewer(url: url6)

//        ImageViewer(url: urlNG)

        Spacer()
    }
}
