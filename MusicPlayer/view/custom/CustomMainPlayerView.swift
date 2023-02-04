//
//  CustomMainPlayerView.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 01/02/2023.
//

import Foundation
import UIKit

class CustomMainPlayerView: UIStackView {
    var pbar: UIProgressView!
    var title: UILabel!
    var singer: UILabel!
    var controlBtns: ControlButtonsView!
    var repeatBtn: UIButton!
    
    init(songTitle: String, artist: String, duration: TimeInterval) {
        super.init(frame: .zero)
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = 8
        
        let songInfo = UIStackView()
        songInfo.axis = .vertical
        songInfo.alignment = .leading
        songInfo.distribution = .fill
        songInfo.spacing = 8
        
        singer = ViewFactory.createLabel(with: artist, size: 25)
        singer.translatesAutoresizingMaskIntoConstraints = false
        singer.textColor = .label
        
        title = ViewFactory.createLabel(with: songTitle, size: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .label
        
        songInfo.addArrangedSubview(singer)
        songInfo.addArrangedSubview(title)
        
        songInfo.addConstraints([
            singer.topAnchor.constraint(equalTo: songInfo.topAnchor),
            singer.trailingAnchor.constraint(equalTo: songInfo.trailingAnchor),
            
            title.trailingAnchor.constraint(equalTo: songInfo.trailingAnchor)
        ])
        
        let horStack = UIStackView()
        horStack.axis = .horizontal
        horStack.alignment = .center
        horStack.distribution = .fill
        horStack.spacing = 16
        
        switch UserDefaults.standard.integer(forKey: K.UserDefaultKey.REPEAT_STATUS) {
        case K.RepeatMode.REPEAT_OFF:
            repeatBtn = ViewFactory.createButton(name: "repeat")
        case K.RepeatMode.REPEAT_ALL:
            repeatBtn = ViewFactory.createButton(name: "repeat.circle.fill")
        default:
            repeatBtn = ViewFactory.createButton(name: "repeat.1.circle.fill")
        }
        
        repeatBtn.imageView?.tintColor = .label
        
        horStack.addArrangedSubview(songInfo)
        horStack.addArrangedSubview(repeatBtn)
        
        horStack.addConstraints([
//            songInfo.topAnchor.constraint(equalTo: horStack.topAnchor),
            songInfo.leadingAnchor.constraint(equalTo: horStack.leadingAnchor),
//            songInfo.bottomAnchor.constraint(equalTo: horStack.bottomAnchor),
            repeatBtn.widthAnchor.constraint(equalTo: horStack.widthAnchor, multiplier: 1/6),
            repeatBtn.trailingAnchor.constraint(equalTo: horStack.trailingAnchor)
        ])
        
        pbar = UIProgressView()
        pbar.translatesAutoresizingMaskIntoConstraints = false
        pbar.tintColor = .label
        
        controlBtns = ControlButtonsView(ofSize: 80, withSpacing: 32)
        controlBtns.translatesAutoresizingMaskIntoConstraints = false
        controlBtns.playpauseBtn.imageView?.tintColor = .label
        controlBtns.backBtn.imageView?.tintColor = .label
        controlBtns.nextBtn.imageView?.tintColor = .label
        
//        addArrangedSubview(singer)
//        addArrangedSubview(title)
        addArrangedSubview(horStack)
        addArrangedSubview(pbar)
        addArrangedSubview(controlBtns)
        
        addConstraints([
//            singer.topAnchor.constraint(equalTo: topAnchor),
//            singer.leadingAnchor.constraint(equalTo: leadingAnchor),
//            singer.trailingAnchor.constraint(equalTo: trailingAnchor),
//
//            title.leadingAnchor.constraint(equalTo: leadingAnchor),
//            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            horStack.topAnchor.constraint(equalTo: topAnchor),
            horStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pbar.leadingAnchor.constraint(equalTo: leadingAnchor),
            pbar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            controlBtns.leadingAnchor.constraint(equalTo: leadingAnchor),
            controlBtns.trailingAnchor.constraint(equalTo: trailingAnchor),
            controlBtns.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
