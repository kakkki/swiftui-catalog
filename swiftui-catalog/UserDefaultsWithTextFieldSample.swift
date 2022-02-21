//
//  UserDefaultsWithTextFieldSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/21.
//

import SwiftUI


class DebugLPSettings: ObservableObject {
    private struct Keys {
        static let userDefaultsWithTextFieldSample = "UserDefaultsWithTextFieldSample"
    }
    
    @Published var lpUrlStr: String {
        didSet {
            if !lpUrlStr.isEmpty {
                UserDefaults.standard.set(lpUrlStr, forKey: Keys.userDefaultsWithTextFieldSample)
            } else {
                UserDefaults.standard.removeObject(forKey: Keys.userDefaultsWithTextFieldSample)
            }
        }
    }

    init() {
        self.lpUrlStr = UserDefaults.standard.string(forKey: Keys.userDefaultsWithTextFieldSample) ?? ""
    }
}

struct UserDefaultsWithTextFieldSample: View {

    var body: some View {
        List {
            WebViewSection()
            WebViewSection()
            WebViewSection()
        }
    }
}

struct WebViewSection: View {
    @ObservedObject var settings = DebugLPSettings()

    var body: some View {
        Section(header:
            Text("アプリでのWebView表示を検証")
                    .foregroundColor(.black)
                .bold()
                .textCase(.lowercase)
        ) {
            VStack(spacing: 12) {
                VStack(spacing: 6) {
                    HStack {
                        Text("・表示したいURLを下記に入力してください")
                            .foregroundColor(.black)
                            .font(.caption)
                        Spacer()
                    }
                    HStack {
                        Text("・WebViewで表示します")
                            .foregroundColor(.black)
                            .font(.caption)
                        Spacer()
                    }
                }
                TextField("URL未入力", text: $settings.lpUrlStr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    if settings.lpUrlStr.isEmpty {
                        print("debug0000 urlが未設定です")
                    } else {
                        print("debug0000 \(settings.lpUrlStr) に遷移します")
                    }
                }) {
                    HStack {
                        Text("入力したURLを表示")
                            .padding(8)
                            .foregroundColor(Color(UIColor.white))
                            .background(Color(UIColor.green))
                            .cornerRadius(8)
                        Spacer()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct UserDefaultsWithTextFieldSample_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsWithTextFieldSample()
    }
}
