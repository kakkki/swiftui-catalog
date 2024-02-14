//
//  ImageAverageColorLoader.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2024/02/14.
//

import SwiftUI
import UIKit

import Foundation

@MainActor
final class ImageAverageColorLoader: ObservableObject {
    enum RequestStatus {
        case blank
        case success
        case failed
    }
    
    @Published var averageColor: UIColor?
    
    @Published var requestStatus: RequestStatus = .blank
    
    func loadFourImages(url1: URL, url2: URL, url3: URL, url4: URL) async {
        do {
            async let (data1, response1) = URLSession.shared.data(from: url1)
            async let (data2, response2) = URLSession.shared.data(from: url2)
            async let (data3, response3) = URLSession.shared.data(from: url3)
            async let (data4, response4) = URLSession.shared.data(from: url4)

            let (imageData1, imageData2, imageData3, imageData4) = try await (data1, data2, data3, data4)
            let (res1, res2, res3, res4) = try await (response1, response2, response3, response4)

            var fetchedImageColors: [UIColor] = []

            func appendAverageColorFromImage(imageData: Data, response: URLResponse) {
                guard let r = response as? HTTPURLResponse, r.statusCode == 200 else {
                    return
                }
                print("debug0000 r.statusCode \(r.statusCode)")
                if let uiImage = UIImage(data: imageData), let averageColor = uiImage.averageColor() {
                    fetchedImageColors.append(averageColor)
                }
            }

            appendAverageColorFromImage(imageData: imageData1, response: res1)
            appendAverageColorFromImage(imageData: imageData2, response: res2)
            appendAverageColorFromImage(imageData: imageData3, response: res3)
            appendAverageColorFromImage(imageData: imageData4, response: res4)
 
            if let averageColor = averageColor(from: fetchedImageColors) {
                self.averageColor = averageColor
                requestStatus = .success
//                requestStatus = .failed
            } else {
                requestStatus = .failed
            }
        } catch {
            requestStatus = .failed
        }
    }

    
    private func averageColor(from colors: [UIColor]) -> UIColor? {
        guard !colors.isEmpty else { return nil }
        
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
