//
//  AllSongCellDelegate.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/01/2023.
//

import Foundation

protocol SongCellDelegate: AnyObject {
    func didClickASong(song: Song)
    func didLongPressASong(song: String)
}
