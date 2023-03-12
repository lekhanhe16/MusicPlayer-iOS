//
//  PopupViewModel.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import Foundation
import UIKit

class PopupViewModel {
    private let action = [Action(name: "Add to a Playlist", icon: "text.badge.plus", segueId: "addtoplaylist"),
                  Action(name: "Love", icon: "heart", segueId: "love"),
                  Action(name: "Play", icon: "play.fill", segueId: "play")]
    func getActions() -> [Action] {
        return action
    }
//    func performAction(_ actionInd: Int) {
//        switch actionInd {
//        case 0:
//            
//        default:
//            return
//        }
//    }
}
