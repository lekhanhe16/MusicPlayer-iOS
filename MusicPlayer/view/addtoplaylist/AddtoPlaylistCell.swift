//
//  AddtoPlaylistCell.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 12/02/2023.
//

import UIKit

class AddtoPlaylistCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var playlistName: UILabel!
    @IBOutlet weak var playlistImg: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension AddtoPlaylistCell: ReusableCellConfig {
    func config(item: DEntity) {
        guard let item = item as? Playlist else { return }
        playlistImg.image = item.img
        playlistName.text = item.playlistName
    }
    
    static var reusableCellName: String {
        "addtoplaylistcell"
    }
    
    static var nibName: String {
        "AddtoPlaylistCell"
    }
}
