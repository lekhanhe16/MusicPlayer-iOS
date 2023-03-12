//
//  PlaylistViewModel.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import Foundation
import UIKit.UIImage

class PlaylistViewModel {
    var list: [PlaylistEntity]!
    private var playlists = [Playlist(img: UIImage(systemName: "play.circle")!, playlistName: "abc"),
                             Playlist(img: UIImage(systemName: "bolt.circle")!, playlistName: "abc"),
                             Playlist(img: UIImage(systemName: "bolt.fill")!, playlistName: "abc")]
    
    init() {
        list = [PlaylistEntity]()
        
    }
    func getPlaylists() -> [Playlist] {
        return playlists
    }
}
