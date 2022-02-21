//
//  EscapingSamples.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/21.
//

import SwiftUI

struct EscapingSamples: View {
    var body: some View {
        VStack {
            EscapingGoodSample()
            EscapingBadSample()
        }
    }
}

struct EscapingGoodSample: View {
    
    class A {
        private let storedClosure: () -> ()

        init(closure: @escaping () -> ()) {
            storedClosure = closure
        }
    }

    class B {
        private var a: A?
        private var count = 0

        func doSomething() {
            a = A(closure: { [weak self] in // selfを弱参照する
                self?.count += 1
            })
        }

        deinit {
            print("debug0000 EscapingGoodSample : deinit") // 呼ばれる
        }
    }

    var body: some View {
        Button(action: {
            execute()
        }) {
            Text("execute Escaping Good Sample")
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                }
        }
    }
    
    func execute() {
        print("debug0000 EscapingGoodSample : execute") // 呼ばれる
        let b = B()
        b.doSomething()
    }
}

struct EscapingBadSample: View {
    
    class A {
        private let storedClosure: () -> ()

        init(closure: @escaping () -> ()) {
            storedClosure = closure
        }
    }

    class B {
        private var a: A?
        private var count = 0

        func doSomething() {
            a = A(closure: {
                self.count += 1 // selfを強参照している
            })
        }

        deinit {
            print("debug0000 EscapingBadSample : deinit") // 呼ばれない
        }
    }
    
    var body: some View {
        // SwiftUIのViewはクロージャでselfを書いても循環参照しない件
        // ViewはButtonの参照を保持していない
            // bodyクロージャでButtonを呼び出しているだけ
        // actionクロージャはViewの値(self.execute())をキャプチャ(コピー)しているだけ
            // Buytonはactionクロージャをescapingしているが
            // [weak self] in にできない
            // Viewが構造体なので値がコピーされている
        // @see https://qiita.com/yimajo/items/4dde5b297f61b699d844
        Button(action: {
            self.execute()
        }) {
            Text("execute Escaping Bad Sample")
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                }
        }
    }
    
    func execute() {
        print("debug0000 EscapingBadSample : execute") // 呼ばれる
        let b = B()
        b.doSomething()
    }
}

struct EscapingSamples_Previews: PreviewProvider {
    static var previews: some View {
        EscapingSamples()
    }
}
