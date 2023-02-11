//
//  MainPlayerViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 30/01/2023.
//

import UIKit

class MainPlayerViewController: UIViewController {
    var text: String? = nil
    var mpView: CustomMainPlayerView!
    var artWork: UIImageView!
    var timer: Timer?
    var duration: TimeInterval!
    var curSong: Song!
    private var viewModel: AllSongViewModel!
    override func viewWillAppear(_ animated: Bool) {
        registerProgressBarHandler()
    }
    @IBOutlet weak var toolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        curSong = getCurSong()
        duration = curSong.duration
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        artWork = UIImageView(image: curSong.artwork)
        artWork.setCornerRadius(with: 5)
        artWork.translatesAutoresizingMaskIntoConstraints = false
        
        mpView = CustomMainPlayerView(songTitle: curSong.title, artist: curSong.artist, duration: curSong.duration)
        mpView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(artWork)
        stackView.addArrangedSubview(mpView)
        
        stackView.addConstraints([
            artWork.widthAnchor.constraint(equalToConstant: view.frame.size.width - 32),
            artWork.heightAnchor.constraint(equalTo: artWork.widthAnchor),
        ])
        
        view.addSubview(stackView)
        view.addConstraints([
            stackView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        // Swift
//        FLEXManager.shared.showExplorer()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlaybackCompleted),
                         name: NSNotification.Name(rawValue: "NextSong"), object: nil)
        
        registerButtonsAction()
    }
    
    @objc func didPlaybackCompleted() {
        updateView()
        
        if !viewModel.checkIsPlaying() {
            mpView.controlBtns.playpauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func getCurSong() -> Song {
        return viewModel.getSongs()![viewModel.getCurSong()]
    }
    func registerProgressBarHandler() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
    }
    
    func updateView() {
        curSong = getCurSong()
        mpView.pbar.progress = 0
        mpView.singer.text = curSong!.artist
        mpView.title.text = curSong!.title
        artWork.image = curSong.artwork
    }
    
    @objc func updateProgressBar() {
        let played = viewModel.getCurrentPlayingSec() + 1
        print(played)
        if played <= duration{
            let percent = Float(played) / Float(duration)
            mpView.pbar.progress = percent
        }
        else {
            mpView.pbar.progress = 1
            timer?.invalidate()
            timer = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1, execute: {
                print("here")
                self.updateView()
            })
        }
    }
    
    func setViewModel(vm: AllSongViewModel) {
        self.viewModel = vm
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func btnCloseClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension MainPlayerViewController : ControlButtonsAction {
    func registerButtonsAction() {
        mpView.controlBtns.backBtn.addTarget(self, action: #selector(self.btnPlayPrevClicked), for: .touchUpInside)
        mpView.controlBtns.playpauseBtn.addTarget(self, action: #selector(self.btnPlayPauseClicked), for: .touchUpInside)
        mpView.controlBtns.nextBtn.addTarget(self, action: #selector(self.btnPlayNextClicked), for: .touchUpInside)
        mpView.repeatBtn.addTarget(self, action: #selector(self.btnRepeatClicked), for: .touchUpInside)
    }
    
    @objc func btnRepeatClicked() {
        switch viewModel.getRepeatStt() {
        case K.RepeatMode.REPEAT_OFF:
            UserDefaults.standard.set(K.RepeatMode.REPEAT_ALL, forKey: K.UserDefaultKey.REPEAT_STATUS)
            mpView.repeatBtn.setImage(UIImage(systemName: "repeat.circle.fill"), for: .normal)
        case K.RepeatMode.REPEAT_ALL:
            UserDefaults.standard.set(K.RepeatMode.REPEAT_ONE, forKey: K.UserDefaultKey.REPEAT_STATUS)
            mpView.repeatBtn.setImage(UIImage(systemName: "repeat.1.circle.fill"), for: .normal)
        case K.RepeatMode.REPEAT_ONE:
            UserDefaults.standard.set(K.RepeatMode.REPEAT_OFF, forKey: K.UserDefaultKey.REPEAT_STATUS)
            mpView.repeatBtn.setImage(UIImage(systemName: "repeat"), for: .normal)
        default:
            return
        }
    }
    @objc func btnPlayPrevClicked() {
        viewModel.resetAudio()
        viewModel.playPrev(touch: true)
        updateView()
    }
    
    @objc func btnPlayPauseClicked() {
        if viewModel.checkIsPlaying() {
            mpView.controlBtns.playpauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        else {
            mpView.controlBtns.playpauseBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        viewModel.playOrPause()
    }
    
    @objc func btnPlayNextClicked() {
        viewModel.resetAudio()
        viewModel.playNext(touch: true)
        updateView()
    }
}
