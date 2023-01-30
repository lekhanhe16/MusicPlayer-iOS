//
//  AllSongViewModel.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 16/01/2023.
//

import Foundation
import MediaPlayer

class AllSongViewModel {
    private var arrSongs: [Song]? = nil
    private var mediaService: MediaPlayerService!
    private var curSong: Int
    private var reachLastSong: Bool = false
    private lazy var shuffleList: [Song]? = nil
    
    func isShuffleOn() -> Bool {
        return UserDefaults.standard.bool(forKey: K.UserDefaultKey.IS_SHUFFLE_ON)
    }
    func isRepeatOn() -> Bool {
        return UserDefaults.standard.bool(forKey: K.UserDefaultKey.IS_REPEAT_ON)
    }
    
    init(mediaService: MediaPlayerService) {
        self.mediaService = mediaService
        let mediaItems = MPMediaQuery.songs().items
        curSong = -1
        if let items = mediaItems {
            self.arrSongs = items.map({(item: MPMediaItem) -> Song in
                return Song(title: item.title!, artist: item.artist!, url: item.assetURL!, artwork: item.artwork!.image(at: CGSize(width: 64, height: 64))!) })
        }
        NotificationCenter.default
                          .addObserver(self,
                                       selector: #selector(self.didPlaybackCompleted),
                         name: NSNotification.Name(rawValue: "AudioFinish"), object: nil)
    }
    
    func bind(indexPath: IndexPath) -> Song{
        return arrSongs![indexPath.row]
    }
    
    func numberOfSongs() -> Int{
        return arrSongs?.count ?? 0
    }
    func getCurSong() -> Int {
        return curSong
    }
    func getSongs() -> [Song]?{
        if isShuffleOn() {
            return shuffleList
        }
        return arrSongs
    }
    
    func play(at index: Int = -1) {
        if index != -1 {
            curSong = index
        }
        
        if curSong != -1 {
            
            let songUrl = isShuffleOn() ? shuffleList![curSong].url : arrSongs![curSong].url
            mediaService.prepare(withURL: songUrl)
            mediaService.play()
        }
    }
    func playNext(touch: Bool = false) {
        if !(touch && reachLastSong) {
            reachLastSong = false
        }
        
        curSong = (curSong + 1 <= arrSongs!.count - 1) ? curSong + 1 : 0
        if curSong == 0 && !touch{
            reachLastSong = true
        }
        
        let songUrl = isShuffleOn() ? shuffleList![curSong].url : arrSongs![curSong].url
        mediaService.prepare(withURL: songUrl)
        if isRepeatOn() || (!isRepeatOn() && !reachLastSong ){
            play()
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NextSong"),object:nil)
    }
    
    func resetAudio() {
        mediaService.resetAudioPlayer()
    }
    
    func checkIsPlaying() -> Bool {
        return mediaService.isPlaying()
    }
    
    func playOrPause(){
        mediaService.playOrPause()
    }
    func playPrev(touch: Bool = false) {
        curSong = (curSong - 1 >= 0) ? curSong - 1 : arrSongs!.count - 1
        
        let songUrl = isShuffleOn() ? shuffleList![curSong].url : arrSongs![curSong].url
        mediaService.prepare(withURL: songUrl)
        if !reachLastSong{
            play()
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NextSong"),object:nil)
    }
    func shuffle() {
        if UserDefaults.standard.bool(forKey: K.UserDefaultKey.IS_SHUFFLE_ON) {
            shuffleList = arrSongs?.shuffled()
            guard let _ = shuffleList else {
                return
            }
            curSong = 0
        }
        else {
            if let arrSongs = arrSongs, let shuffleList = shuffleList {
                for (index, song) in arrSongs.enumerated() {
                    if song.url == shuffleList[curSong].url {
                        curSong = index
                        break
                    }
                }
            }
        }
    }
    
    @objc func didPlaybackCompleted() {
        print("vm audio finish \(curSong)")
        playNext()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "AudioFinish"), object: nil)
    }
}
