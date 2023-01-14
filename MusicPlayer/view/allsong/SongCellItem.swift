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
    
    weak var delegate: SongCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func rowItemClicked() {
        if delegate == nil {
            print("nil")
        }
        delegate?.didPlayASong()
    }
}
