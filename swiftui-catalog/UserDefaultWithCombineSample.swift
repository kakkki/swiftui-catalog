//
//  UserDefaultWithCombineSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/18.
//

import SwiftUI
import Combine

struct UserDefaultWithCombineSample: View {
    @ObservedObject var settingsStore: SettingsStore

    init(_ settingsStore: SettingsStore) {
        self.settingsStore = settingsStore
    }
    
    var body: some View {
        let _ = print("debug0000 body UserDefaultWithCombineSample")
        NavigationView {
            Form {
                Toggle(isOn: $settingsStore.settingActivated) {
                    Text("Setting Activated")
                }
                Toggle(isOn: $settingsStore.settingActivatedSecond) {
                    Text("Setting Activated Second")
                }
                Toggle(isOn: $settingsStore.settingActivatedBodyNotRecreate) {
                    Text("Setting Activated BodyNotRecreate")
                }
            }.navigationBarTitle(Text("Settings"))
        }
    }}

class SettingsStore: ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    var settingActivated: Bool = UserDefaults.settingActivated {
        willSet {
            UserDefaults.settingActivated = newValue
            objectWillChange.send()
            // willChange使わなくてもObservableObjectを実装したクラスにはobjectWillChangeがすでにある
//            willChange.send()
        }
    }

    @Published var settingActivatedSecond: Bool = UserDefaults.settingActivatedSecond {
        willSet {
            UserDefaults.settingActivatedSecond = newValue
        }
    }

    var settingActivatedBodyNotRecreate: Bool = UserDefaults.settingActivatedSecond {
        willSet {
            UserDefaults.settingActivatedBodyNotRecreate = newValue
            // これもコメントアウトするとToggleをタップしても更新されない
            // UserDefaultの値は更新されるが、objectWillChange.send()されないことで、
            // サブスクライブしてるViewに変更が流れない
            // よってbodyが再生成されない(toggleの操作なのでUI自体は変わるが)
//            objectWillChange.send()
        }
    }
}

extension UserDefaults {

    private struct Keys {
        static let settingActivated = "SettingActivated"
        static let settingActivatedSecond = "SettingActivatedSecond"
        static let settingActivatedBodyNotRecreate = "SettingActivatedBodyNotRecreate"
    }

    static var settingActivated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.settingActivated)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.settingActivated)
        }
    }
    static var settingActivatedSecond: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.settingActivatedSecond)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.settingActivatedSecond)
        }
    }
    static var settingActivatedBodyNotRecreate: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.settingActivatedBodyNotRecreate)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.settingActivatedBodyNotRecreate)
        }
    }
}

struct UserDefaultWithCombineSample_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultWithCombineSample(SettingsStore())
    }
}
