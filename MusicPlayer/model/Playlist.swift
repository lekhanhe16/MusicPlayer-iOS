//
//  Playlist.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import Foundation
import UIKit.UIImage

class Playlist: DEntity{
    let img: UIImage
    let playlistName: String
    let arrSongs = [Song]()
    let isFav: Bool = true
    init(img: UIImage, playlistName: String) {
        self.img = img
        self.playlistName = playlistName
    }
}
