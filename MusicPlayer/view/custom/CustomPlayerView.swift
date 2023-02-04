//
//  CustomPlayerView.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 17/01/2023.
//

import Foundation
import UIKit

class CustomPlayerView: UIStackView{
    var controlBtns: UIStackView!
    var songInfo: SongInfoStackView!
    init(song: Song) {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fill
        alignment = .fill
        let songImg = ViewFactory.createImageView(image: song.artwork)
        songImg.translatesAutoresizingMaskIntoConstraints = false
        songImg.setCornerRadius(with: 16)
        
        songInfo = SongInfoStackView(title: song.title, artist: song.artist)
        songInfo.translatesAutoresizingMaskIntoConstraints = false
        
        controlBtns = ControlButtonsView(ofSize: 32, withSpacing: 16)
        controlBtns.translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(songImg)
        addArrangedSubview(songInfo)
        addArrangedSubview(controlBtns)
        songInfo.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
//        songInfo.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 200), for: .horizontal)
//        songInfo.setContentCompressionResistancePriority(UILayoutPriority(900), for: .vertical)
//
        songImg.setContentCompressionResistancePriority(UILayoutPriority(200), for: .vertical)
        songInfo.setContentCompressionResistancePriority(UILayoutPriority(200), for: .vertical)
        
        addConstraints([
            songImg.centerYAnchor.constraint(equalTo: centerYAnchor),
            songImg.trailingAnchor.constraint(equalTo: songInfo.leadingAnchor, constant: -8),
            songInfo.centerYAnchor.constraint(equalTo: centerYAnchor),
            songInfo.trailingAnchor.constraint(equalTo: controlBtns.leadingAnchor, constant: -8),

            controlBtns.centerYAnchor.constraint(equalTo: centerYAnchor),
            controlBtns.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
