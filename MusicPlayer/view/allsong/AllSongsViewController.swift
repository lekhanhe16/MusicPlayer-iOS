//
//  AllSongsViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/01/2023.
//

import UIKit
import MediaPlayer

class AllSongsViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var allSongTableView: UITableView!
    private var allsongViewModel: AllSongViewModel!
    
    func setViewModel(vm: AllSongViewModel) {
        self.allsongViewModel = vm
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allSongTableView.delegate = self
        allSongTableView.dataSource = self
        allSongTableView.register(UINib(nibName: SongCellItem.nibName, bundle: nil), forCellReuseIdentifier: SongCellItem.reusableCellName)
    }

}

extension AllSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCellItem.reusableCellName, for: indexPath) as! SongCellItem
        cell.delegate = UIApplication.shared.connectedScenes.compactMap{($0 as? UIWindowScene)?.keyWindow}.first?.rootViewController?.children.first as? SongCellDelegate
        cell.playSong(song: allsongViewModel.getSongs()![indexPath.row])
        allsongViewModel.play(at: indexPath.row)
        
    }
}

extension AllSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allsongViewModel.getSongs()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCellItem.reusableCellName, for: indexPath) as! SongCellItem
        cell.delegate = UIApplication.shared.connectedScenes.compactMap{($0 as? UIWindowScene)?.keyWindow}.first?.rootViewController?.children.first as? SongCellDelegate
        
        let song = allsongViewModel.bind(indexPath: indexPath)
        cell.bindData(item: song)
        let lpgr = UILongPressGestureRecognizer(target: self
                                                , action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = cell
        cell.addGestureRecognizer(lpgr)
        return cell
    }
    
}

extension AllSongsViewController {
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            //When lognpress is start or running
        }
        else {
            //When lognpress is finish
            if let cell = (gestureReconizer.delegate as? SongCellItem) {
//                cell.delegate.didLongPressASong(song: cell.song.text!)
                
                let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ASPopUpViewController", creator: { coder in
                    return ASPopUpViewController(coder: coder, songTitle: cell.song.text!)
                })
                self.addChild(popVC)
                popVC.view.frame = CGRect(x: 60, y: 240, width: self.view.frame.size.width-120, height: self.view.frame.height-480)
                popVC.view.layer.cornerRadius = 32
                self.view.addSubview(popVC.view)
                
                self.view.addConstraints([
                    popVC.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    popVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ])
                popVC.didMove(toParent: self)
            }
        }
    }
}
