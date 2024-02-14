//
//  AverageColorImageWithCombine.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2024/02/05.
//

import SwiftUI
import Combine
import UIKit


// Combineバージョン
class ImageLoaderWithCombine: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(fromURL url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
}

struct ImageViewerWithCombine: View {

    @ObservedObject var loader = ImageLoaderWithCombine()
    let url: URL

    var body: some View {
        Group {
            if let image = loader.image {
                VStack {
                    // UIImageからSwiftUIのImageに変換
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        // ここで平均色を計算し、何らかの形で使用する
                    
                    if let averageColor = image.averageColor() {
                        HStack {
                            Text("hoge")
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
                Text("Loading...")
            }
        }.onAppear {
            loader.load(fromURL: url)
        }
    }
}


#Preview {
    let logoURL = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/53527ded397ef227854b3bfb78a3b490.jpg")!
    
//    let logoURL = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/53527ded397ef227854b3bfb78a3b490.jpg")!
    
    let url1 = URL(string: "https://base-ec2if.akamaized.net/c/w=585,h=585,a=0,u=0,f=webp/images/item/origin/a2472f9d975a62149a331a82a392b1c3.jpg")!
    let url2 = URL(string: "https://base-ec2if.akamaized.net/images/item/origin/c6226f70eb734e0bed220065ba8f4757.png")!
    let url3 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/47f79aecfa559597b0e39127d7db3a6a.jpg")!
    let url4 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/55d9562bb97b06b6c02af80dbfa48719.jpg")!

    // みかん
    let url5 = URL(string: "https://base-ec2if.akamaized.net/c/w=384,h=384,a=0,u=0,f=webp/images/item/origin/9ab0c20ba950ed001ec2c926d1466df8.jpg")!

    // しまのみかん
    let url6 = URL(string: "https://base-ec2if.akamaized.net/c/w=288,h=288,a=0,u=0,f=webp/images/user/logo/c7dbb7519f6c931a62613f95e8160112.jpeg")!



    return VStack {
        ImageViewerWithCombine(url: url6)
    }
}


// TODO: ロジックを理解する
// @see: https://github.com/Wuleslie/LWImageThemeColor/blob/master/LWImageThemeColor/LWImageThemeColor.swift
extension UIImage {
    func averageColor() -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
