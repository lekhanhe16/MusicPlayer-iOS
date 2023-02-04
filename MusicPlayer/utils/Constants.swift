//
//  Constants.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 19/01/2023.
//

import Foundation
import UIKit.UIDevice

struct K {
    struct ReuseableCell {
        static let songCellIdentifier: String = "allsongcell"
    }
    
    struct UserDefaultKey {
        static let IS_SHUFFLE_ON: String = "isShulffeOn"
        static let REPEAT_STATUS: String = "repeatStatus"
    }
    
    struct RepeatMode {
        static let REPEAT_OFF = 0
        static let REPEAT_ALL = 1
        static let REPEAT_ONE = 2
    }
    struct BarItemTitle {
        static let SEARCH: String = "Search"
        static let SHUFFLE: String = "Shuffle"
    }
}
