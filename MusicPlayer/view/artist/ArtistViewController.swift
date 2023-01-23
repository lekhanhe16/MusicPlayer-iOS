//
//  ArtistViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/01/2023.
//

import UIKit
import MediaPlayer

class ArtistViewController: UIViewController {
    var viewModel: AllSongViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let artists = MPMediaQuery.artists().collections
        if let artists = artists {
            for artist in artists {
                let item = artist.representativeItem
                let artistName = item?.artist
                print(artistName!)
            }
        }
    }

}
