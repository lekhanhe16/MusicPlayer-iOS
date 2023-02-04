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
    private var fragments: [UIViewController] = []
    private var currentIndex: Int = 0
    // MARK: IBOutlets
    
    @IBOutlet weak var playView: UIControl!
    
    @IBOutlet weak var viewPager: LZViewPager!
    
    private var playViewHeightConstraint: NSLayoutConstraint?
    // MARK: IBActions
    private var viewmodel: AllSongViewModel!
    
    func setViewModel(vm: AllSongViewModel) {
        self.viewmodel = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: K.UserDefaultKey.IS_SHUFFLE_ON)
        navigationItem.titleView?.tintColor = .orange
        
        setUpViewPager()
        setupPlayerControlView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlaybackCompleted),
                                               name: NSNotification.Name(rawValue: "NextSong"), object: nil)
        // Do any additional setup after loading the view.
        
                        let dir = "/Users/kl/Library/Developer/CoreSimulator/Devices/C05290DC-8160-415F-A91E-5AFEBB57BF33/data/Containers/Shared/AppGroup/D2B8FC51-C6CE-4608-9A62-E8B52C824179/File\\ Provider\\ Storage/Downloads"
         
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier) {
        case "openmainplayer":
            let vc = segue.destination as! MainPlayerViewController
            vc.text = viewmodel.getSongs()![viewmodel.getCurSong()].title
        default:
            print("default")
        }
    }
    @objc func playViewTouched() {
        print("touch")
        performSegue(withIdentifier: "openmainplayer", sender: self)
    }
    @objc func didPlaybackCompleted() {
        let song = viewmodel.getSongs()![viewmodel.getCurSong()]
        updatePlayerView(song: song)
        
        if !viewmodel.checkIsPlaying() {
            ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.playpauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    func setupPlayerControlView(){
        playViewHeightConstraint = playView.heightAnchor.constraint(equalToConstant: 0)
        playViewHeightConstraint?.isActive = true
        playView.layer.cornerRadius = playView.bounds.height / 3
        
        playView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playViewTouched)))
    }
    func setUpViewPager() {
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
                    showToast(message: "Shuffle: ON", font: .systemFont(ofSize: 17), duration: 2.0)
                }
                else {
                    showToast(message: "Shuffle: OFF", font: .systemFont(ofSize: 17), duration: 2.0)
                }
            default:
                return
        }
    }
    
    func updatePlayerView(song: Song) {
        
        playViewHeightConstraint?.isActive = false
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
        ])
        
        registerButtonsAction()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NextSong"), object: nil)
    }
}

extension ViewController : ControlButtonsAction {
    func registerButtonsAction() {
        ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.backBtn.addTarget(self, action: #selector(self.btnPlayPrevClicked), for: .touchUpInside)
        ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.playpauseBtn.addTarget(self, action: #selector(self.btnPlayPauseClicked), for: .touchUpInside)
        ((playView.subviews[0] as? CustomPlayerView)!.controlBtns as? ControlButtonsView)!.nextBtn.addTarget(self, action: #selector(self.btnPlayNextClicked), for: .touchUpInside)
    }
    
    @objc func btnPlayPrevClicked() {
        viewmodel.resetAudio()
        viewmodel.playPrev(touch: true)
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
        viewmodel.resetAudio()
        viewmodel.playNext(touch: true)
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

extension ViewController: SongCellDelegate {
    func didLongPressASong(song: String) {
        showToast(message: song, font: .systemFont(ofSize: 17), duration: 5.0)
    }
    
    func didClickASong(song: Song) {
        updatePlayerView(song: song)
        viewmodel.resetAudio()
    }
}
