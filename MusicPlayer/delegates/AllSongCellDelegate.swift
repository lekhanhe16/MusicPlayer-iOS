//
//  AllSongCellDelegate.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/01/2023.
//

import Foundation

protocol SongCellDelegate: AnyObject {
    func didPlayASong(song: Song)
}
