//
//  ControlButtonsAction.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/02/2023.
//

import Foundation

@objc protocol ControlButtonsAction {
    func registerButtonsAction()
    @objc func btnPlayPrevClicked()
    @objc func btnPlayPauseClicked()
    @objc func btnPlayNextClicked()
}
