//
//  ResuableCellUtil.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 19/01/2023.
//

import Foundation

protocol SongReusableCellConfig {
    static var reusableCellName: String {get}
    static var nibName: String {get}
    func bindData(item: Song)
}
