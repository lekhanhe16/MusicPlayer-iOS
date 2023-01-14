//
//  AllSongsViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/01/2023.
//

import UIKit

class AllSongsViewController: UIViewController {

    @IBOutlet weak var allSongTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSongTableView.delegate = self
        allSongTableView.dataSource = self
        allSongTableView.register(UINib(nibName: "SongCellItem", bundle: nil), forCellReuseIdentifier: "allsongcell")
        // Do any additional setup after loading the view.
    }

}

extension AllSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "allsongcell", for: indexPath) as! SongCellItem
        cell.rowItemClicked()
    }
}

extension AllSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allsongcell", for: indexPath) as! SongCellItem
        print(self)
        cell.delegate = self
        return cell
    }
}

extension AllSongsViewController: SongCellDelegate {
    func didPlayASong() {
        print("hello honey")
    }
}
