//
//  Song.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 16/01/2023.
//

import Foundation
import UIKit.UIImage

class Song {
    let title: String
    let artist: String
    let url: URL
    let artwork: UIImage
    let duration: TimeInterval
    init(title: String, artist: String, url: URL, artwork: UIImage, duration: TimeInterval) {
        self.title = title
        self.artist = artist
        self.url = url
        self.artwork = artwork
        self.duration = duration
    }
}
