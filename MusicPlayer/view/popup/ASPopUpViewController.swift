//
//  ASPopUpViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 28/01/2023.
//

import UIKit

class ASPopUpViewController: UIViewController {

    @IBOutlet weak var songImg: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var listAction: UICollectionView!
    
    let action = [Action(name: "Add to a Playlist", icon: "text.badge.plus"),
                  Action(name: "Love", icon: "heart"),
                  Action(name: "Close", icon: "xmark")]
    var songTitle: String = ""
    var artist: String = ""
    var img: UIImage!
    var dataSource: UICollectionViewDiffableDataSource<Int, Action>!
    init?(coder: NSCoder, songTitle: String, artist: String, img: UIImage) {
        super.init(coder: coder)
        self.songTitle = songTitle
        self.artist = artist
        self.img = img
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.8)
        songTitleLabel.text = songTitle
        songArtist.text = artist
        songImg.image = img
        self.showAnimate()
        setUpListActionView()
        createDataSource()
        reloadDataset()
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Action>(collectionView: listAction) { collectionView,indexPath,action in
            print("action \(action)")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionItemCell.reuseIdentifier, for: indexPath) as! ActionItemCell
            cell.config(with: action)
            return cell
        }
    }
    
    func reloadDataset() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Action>()
        snapshot.appendSections([0])
        snapshot.appendItems(action, toSection: 0)
        dataSource?.apply(snapshot)
    }
    func setUpListActionView() {
        listAction.collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnv in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        listAction.register(UINib(nibName: "ActionItemCell", bundle: nil), forCellWithReuseIdentifier: ActionItemCell.reuseIdentifier)
    }
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        });
    }
}

struct Action: Hashable {
    let name: String
    let icon: String
}
