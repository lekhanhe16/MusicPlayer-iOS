//
//  ViewFactory.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 17/01/2023.
//

import Foundation
import UIKit

class ViewFactory {
    static func createImageView(image: UIImage!) -> UIImageView {
        let img = UIImageView(image: image)
        img.translatesAutoresizingMaskIntoConstraints = false
        
        // 48x48 image
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
//        img.frame.size = CGSize(width: 48, height: 48)
        // rounded image
        img.setRounded()
        return img
    }
    static func createLabel(with text: String, size: CGFloat) -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = UIColor(named: "textColor")
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.text = text
        return label
    }
    
    static func createButton(name: String) -> UIButton {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: name, withConfiguration: config)

        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .black
        return button
    }
}

extension UIImageView {

   func setRounded() {
       self.layer.cornerRadius = 16
       self.clipsToBounds = true
   }
}
