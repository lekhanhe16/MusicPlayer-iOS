//
//  SwinjectStoryboard+Extension.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 17/01/2023.
//

import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup(){
        
        defaultContainer.register(MediaPlayerService.self) {_ in MediaPlayerService()}
        
        defaultContainer.register(AllSongViewModel.self, name: "allsongvm") {resolver in
            let viewmodel = AllSongViewModel(mediaService: resolver.resolve(MediaPlayerService.self)!)
            return viewmodel
        }.inObjectScope(.weak)
        
        defaultContainer.storyboardInitCompleted(ViewController.self){ resolver, controller in
            controller.setViewModel(vm: resolver.resolve(AllSongViewModel.self, name: "allsongvm")!)
        }
        defaultContainer.storyboardInitCompleted(AllSongsViewController.self){ resolver, controller in
            controller.setViewModel(vm: resolver.resolve(AllSongViewModel.self, name: "allsongvm")!)
        }
        
        
    }
}

