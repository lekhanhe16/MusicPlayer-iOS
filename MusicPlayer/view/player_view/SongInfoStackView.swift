//
//  SongInfoStackView.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 17/01/2023.
//

import Foundation
import UIKit
class SongInfoStackView: UIStackView {
    init(title: String, artist: String) {
        super.init(frame: .zero)
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 16
        
        let title = ViewFactory.createLabel(with: title, size: 17)
        title.translatesAutoresizingMaskIntoConstraints = false
        let artist = ViewFactory.createLabel(with: artist, size: 12)
        artist.translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(title)
        addArrangedSubview(artist)
        
        addConstraints([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            artist.topAnchor.constraint(equalTo: title.bottomAnchor),
            artist.leadingAnchor.constraint(equalTo: leadingAnchor),
            artist.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
