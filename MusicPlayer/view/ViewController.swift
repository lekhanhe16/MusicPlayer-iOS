//
//  ViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 01/01/2023.
//

import UIKit
import LZViewPager

class ViewController: UIViewController {
    var fragments: [UIViewController] = []
    var currentIndex: Int = 0
    // MARK: IBOutlets
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var viewPager: LZViewPager!
    
    // MARK: IBActions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView?.tintColor = .orange
        setUpViewPager()
        playView.isHidden = true
        // Do any additional setup after loading the view.
    }

    func setUpViewPager() {
        print("self \(self)")
        let allsongs = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AllSongs")
        let playlist = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Albums")
        let artist = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Artist")
        allsongs.title = "All Songs"
        playlist.title = "Playlist"
        artist.title = "Artist"
        
        viewPager.delegate = self
        viewPager.dataSource = self
        viewPager.hostController = self
        fragments = [allsongs, playlist, artist]
        viewPager.reload()
    }
}

extension ViewController: LZViewPagerDataSource{
    func numberOfItems() -> Int {
        return fragments.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return fragments[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .systemOrange
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return .black
    }
}

extension ViewController: LZViewPagerDelegate {
    func didSelectButton(at index: Int) {
        currentIndex = index
    }
    func willTransition(to index: Int) {
        
    }
    func didTransition(to index: Int) {
    }
}

//extension ViewController: SongCellDelegate {
//    func didPlayASong() {
//        print("Heslo hosney")
//        playView.isHidden = false
//    }
//}
