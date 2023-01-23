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
    var allsongViewModel: AllSongViewModel!
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
        return cell
    }
}
