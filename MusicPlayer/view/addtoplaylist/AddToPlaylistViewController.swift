//
//  AddToPlaylistViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import UIKit

class AddToPlaylistViewController: UIViewController {

    lazy var input: UITextField?  = nil
    @IBOutlet weak var playlists: UITableView!
    private var playlistVM: PlaylistViewModel!
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playlists.dataSource = self
        playlists.delegate = self
        playlists.register(UINib(nibName: AddtoPlaylistCell.nibName, bundle: nil), forCellReuseIdentifier: AddtoPlaylistCell.reusableCellName)
    }

    func setPlaylistVm(vm: PlaylistViewModel) {
        self.playlistVM = vm
    }
}

extension AddToPlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistVM.getPlaylists().count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddtoPlaylistCell.reusableCellName, for: indexPath) as! AddtoPlaylistCell
        if indexPath.row == 0 {
            cell.config(item: Playlist(img: UIImage(systemName: "plus.square")!, playlistName: "New Playlist"))
        }
        else {
            cell.config(item: playlistVM.getPlaylists()[indexPath.row-1])
        }
        return cell
    }
    
}
extension AddToPlaylistViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            print("here")
        }
        else {
            showToast(message: "x", font: .systemFont(ofSize: 17), duration: 1)
        }
    }
}
extension AddToPlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "New Playlist", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Enter a playlist name"
            self.input = textField
            self.input?.delegate = self
        }

        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
