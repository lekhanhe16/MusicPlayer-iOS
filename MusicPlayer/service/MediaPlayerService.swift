//
//  MediaPlayerService.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 18/01/2023.
//

import Foundation
import AVFoundation

class MediaPlayerService: NSObject {
    private var avPlayer: AVAudioPlayer?
    override init() {
        super.init()
    }
    func prepare(withURL songUrl: URL) {
        if avPlayer == nil {
            do {
                avPlayer = try AVAudioPlayer(contentsOf: songUrl)
                avPlayer!.delegate = self
            }
            catch {
                print(error)
            }
        }
    }
    
    func resetAudioPlayer() {
        avPlayer = nil
    }
    func play() {
        avPlayer?.play()
    }
    
    func isPlaying() -> Bool{
        return avPlayer?.isPlaying ?? false
    }
    
    func playOrPause() {
        guard let avPlayer = avPlayer else {
            play()
            return
        }
        if avPlayer.isPlaying {
            avPlayer.pause()
        }
        else  {
            avPlayer.prepareToPlay()
            avPlayer.play()
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
