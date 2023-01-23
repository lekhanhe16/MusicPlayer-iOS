//
//  Constants.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 19/01/2023.
//

import Foundation

struct K {
    struct ReuseableCell {
        static let songCellIdentifier: String = "allsongcell"
    }
    
    struct UserDefaultKey {
        static let IS_SHUFFLE_ON: String = "isShulffeOn"
        static let IS_REPEAT_ON: String = "isRepeatOn"
    }
    
    struct BarItemTitle {
        static let SEARCH: String = "Search"
        static let SHUFFLE: String = "Shuffle"
    }
}
