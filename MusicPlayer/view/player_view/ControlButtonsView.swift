//
//  ControlButtonsView.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 18/01/2023.
//

import Foundation
import UIKit

class ControlButtonsView: UIStackView {
    init() {
        super.init(frame: .zero)
        let backBtn = ViewFactory.createButton(name: "backward.fill")
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        let playpauseBtn = ViewFactory.createButton(name: "play.fill")
        playpauseBtn.translatesAutoresizingMaskIntoConstraints = false
        let nextBtn = ViewFactory.createButton(name: "forward.fill")
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 16
        
        addArrangedSubview(backBtn)
        addArrangedSubview(playpauseBtn)
        addArrangedSubview(nextBtn)
        
        addConstraints([
            backBtn.topAnchor.constraint(equalTo: topAnchor),
            backBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor),
            backBtn.trailingAnchor.constraint(equalTo: playpauseBtn.leadingAnchor, constant: -16),
            backBtn.widthAnchor.constraint(equalToConstant: 32),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor),
            
            playpauseBtn.topAnchor.constraint(equalTo: topAnchor),
            playpauseBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            playpauseBtn.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor, constant: -16),
            playpauseBtn.widthAnchor.constraint(equalToConstant: 32),
            playpauseBtn.heightAnchor.constraint(equalTo: playpauseBtn.widthAnchor),
            
            nextBtn.topAnchor.constraint(equalTo: topAnchor),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: 32),
            nextBtn.heightAnchor.constraint(equalTo: nextBtn.widthAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
