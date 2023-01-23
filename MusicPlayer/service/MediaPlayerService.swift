//
//  MediaPlayerService.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 18/01/2023.
//

import Foundation
import AVFoundation
//import NotificationCenter

class MediaPlayerService: NSObject {
    var avPlayer: AVAudioPlayer?
    var curPlaybackTime: Double?
    var delegate: MediaPlayerServiceDelegate!
    override init() {
        super.init()
    }
    func play(withURL songUrl: URL) {
        do {
            avPlayer = try AVAudioPlayer(contentsOf: songUrl)
            avPlayer!.delegate = self
            avPlayer!.play()
        }
        catch {
            print(error)
        }
        
    }
    func isPlaying() {
        if avPlayer!.isPlaying {
            curPlaybackTime = avPlayer!.currentTime
            avPlayer!.pause()
        }
        else if let time = curPlaybackTime {
            avPlayer!.play(atTime: time)
        }
    }
    
}

extension MediaPlayerService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("post notification audio finish")
            avPlayer!.stop()
            avPlayer = nil
            NotificationCenter.default
                        .post(name: NSNotification.Name(rawValue: "AudioFinish"),
                         object: nil)
        }
    }
}
