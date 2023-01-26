//
//  ViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 01/01/2023.
//

import UIKit
import LZViewPager
import MediaPlayer
class ViewController: UIViewController {
    var fragments: [UIViewController] = []
    var currentIndex: Int = 0
    // MARK: IBOutlets
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var viewPager: LZViewPager!
    
    var playViewHeightConstraint: NSLayoutConstraint?
    // MARK: IBActions
    var viewmodel: AllSongViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: K.UserDefaultKey.IS_SHUFFLE_ON)
        navigationItem.titleView?.tintColor = .orange
        
        setUpViewPager()
        setupPlayerControlView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlaybackCompleted),
                         name: NSNotification.Name(rawValue: "NextSong"), object: nil)
        // Do any additional setup after loading the view.
    }
        
    @objc func didPlaybackCompleted() {
        print("vc audio finish")
        let song = viewmodel.getSongs()![viewmodel.getCurSong()]
        updatePlayerView(song: song)
    }
    func setupPlayerControlView(){
        playView.isHidden = true
        playViewHeightConstraint = playView.heightAnchor.constraint(equalToConstant: 0)
        playViewHeightConstraint?.isActive = true
        playView.layer.cornerRadius = playView.bounds.height / 3
        
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
    
    @IBAction func btnShuffleClicked(_ sender: UIBarButtonItem) {
        switch sender.title {
            case K.BarItemTitle.SHUFFLE:
                UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: K.UserDefaultKey.IS_SHUFFLE_ON), forKey: K.UserDefaultKey.IS_SHUFFLE_ON)
                if UserDefaults.standard.bool(forKey: K.UserDefaultKey.IS_SHUFFLE_ON) {
                    viewmodel.shuffle()
                    viewmodel.play(at: Int.random(in: 0..<viewmodel.numberOfSongs()))
                    updatePlayerView(song: viewmodel.getSongs()![viewmodel.getCurSong()])
                    showToast(message: "Shuffle: ON", font: .systemFont(ofSize: 17))
                }
                else {
                    showToast(message: "Shuffle: OFF", font: .systemFont(ofSize: 17))
                }
            default:
                return
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NextSong"), object: nil)
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
    
    func updatePlayerView(song: Song) {
        
        playViewHeightConstraint?.isActive = false
        playView.isHidden = false
        for view in playView.subviews {
            view.removeFromSuperview()
        }
        let customerPlayerView = CustomPlayerView(song: song)
        customerPlayerView.translatesAutoresizingMaskIntoConstraints = false
        customerPlayerView.isLayoutMarginsRelativeArrangement = true
        customerPlayerView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        playView.addSubview(customerPlayerView)
        
        playView.addConstraints([
            customerPlayerView.topAnchor.constraint(equalTo: playView.topAnchor),
            customerPlayerView.leadingAnchor.constraint(equalTo: playView.leadingAnchor),
            customerPlayerView.trailingAnchor.constraint(equalTo: playView.trailingAnchor),
            customerPlayerView.bottomAnchor.constraint(equalTo: playView.bottomAnchor)
//            customerPlayerView.centerYAnchor.constraint(equalTo: playView.centerYAnchor)
        ])
        print("sub view \(playView.subviews[0])")
        ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.backBtn.addTarget(self, action: #selector(self.btnPlayPrevClicked), for: .touchUpInside)
        ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.playpauseBtn.addTarget(self, action: #selector(self.btnPlayPauseClicked), for: .touchUpInside)
        ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.nextBtn.addTarget(self, action: #selector(self.btnPlayNextClicked), for: .touchUpInside)
    }
    @objc func btnPlayPrevClicked() {
        viewmodel.playPrev()
    }
    
    @objc func btnPlayPauseClicked() {
        if viewmodel.checkIsPlaying() {
            ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.playpauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        else {
            ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.playpauseBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        viewmodel.playOrPause()
    }
    
    @objc func btnPlayNextClicked() {
        viewmodel.playNext()
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

extension ViewController: SongCellDelegate {
    func didPlayASong(song: Song) {
        updatePlayerView(song: song)
    }
}
