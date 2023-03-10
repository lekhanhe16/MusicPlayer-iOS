//
//  ActionItemCell.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 11/02/2023.
//

import UIKit

class ActionItemCell: UICollectionViewCell {
    @IBOutlet weak var actionIcon: UIImageView!
    @IBOutlet weak var actionName: UILabel!
    static let reuseIdentifier = "ActionItemCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with action: Action) {
        actionName?.text = action.name
        actionIcon?.image = UIImage(systemName: action.icon)
    }
}
