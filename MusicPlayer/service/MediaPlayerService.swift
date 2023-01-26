//
//  MediaPlayerService.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 18/01/2023.
//

import Foundation
import AVFoundation

class MediaPlayerService: NSObject {
    var avPlayer: AVAudioPlayer?
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
    
    func isPlaying() -> Bool{
        return avPlayer!.isPlaying
    }
    
    func playOrPause() {
        print(avPlayer!.isPlaying)
        if avPlayer!.isPlaying {
            avPlayer!.pause()
        }
        else  {
            avPlayer!.prepareToPlay()
            avPlayer!.play()
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
