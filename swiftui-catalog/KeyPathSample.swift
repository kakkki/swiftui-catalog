//
//  KeyPathSample.swift
//  swiftui-catalog
//
//  Created by Atsuki Kakehi on 2022/02/19.
//

import SwiftUI

struct Song {
    var title: String
    var artist: Artist
}

struct Artist {
    var name: String
}

struct KeyPathSample: View {
    let song = Song(title: "Let it Be", artist: Artist(name: "Beatles"))
    
    @State var songTitle = ""
    @State var artistName = ""

    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    songTitle = execute()
                }) {
                    Text("execute KeyPath")
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                }
                Text("Song Title : \(songTitle)")
            }
            VStack {
                Button(action: {
                    artistName = executeNestedKeypath()
                }) {
                    Text("execute Nested KeyPath")
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        }
                }
                Text("Song's Artist Name : \(artistName)")
            }
        }
    }
    
    func execute() -> String {
        let keyPath: KeyPath<Song, String> = \.title
        return song[keyPath: keyPath]
    }
    
    func executeNestedKeypath() -> String {
        let artistKeyPath: KeyPath<Song, Artist> = \.artist
        let nameKeyPath: KeyPath<Artist, String> = \.name
        let artistNameKeyPath = artistKeyPath.appending(path: nameKeyPath)
        return song[keyPath: artistNameKeyPath]
    }
}

struct KeyPathSample_Previews: PreviewProvider {
    static var previews: some View {
        KeyPathSample()
    }
}
