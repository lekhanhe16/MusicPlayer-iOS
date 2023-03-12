//
//  SongCellItem.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 02/01/2023.
//

import UIKit

class SongCellItem: UITableViewCell {

    @IBOutlet weak var song: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var songImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    weak var delegate: SongCellDelegate!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        print(delegate)
        // Configure the view for the selected state
        
        if selected == true {
//            delegate.didPlayASong(song: Song(title: "", artist: "", url: URL(fileURLWithPath: ""), artwork: UIImage()))
        }
    }
    
    func playSong(song: Song){
        self.delegate.didClickASong(song: song)
    }
}

extension SongCellItem: ReusableCellConfig {
    static var reusableCellName: String {
        return K.ReuseableCell.songCellIdentifier
    }
    
    func config(item: DEntity) {
        guard let item = item as? Song else { return }
        song.text = item.title
        songArtist.text = item.artist
        songImg.image = item.artwork
    }
    
    static var nibName: String {
        return "SongCellItem"
    }
    
}
