//
//  ASPopUpViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 28/01/2023.
//

import UIKit

class ASPopUpViewController: UIViewController {

    @IBOutlet weak var songTitleLabel: UILabel!
    var songTitle: String = ""
    init?(coder: NSCoder, songTitle: String) {
        super.init(coder: coder)
        self.songTitle = songTitle
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        songTitleLabel.text = songTitle
        self.showAnimate()
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        });
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;

            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.dismiss(animated: true)
                }
        });
    }
}
