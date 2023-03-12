//
//  ASPopUpViewController.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 28/01/2023.
//

import UIKit

class ASPopUpViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var songImg: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var listAction: UICollectionView!
    let viewModel = PopupViewModel()
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
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
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(outterOutletTouched))
//        gesture.delegate = self
//        gesture.cancelsTouchesInView = true
//        view.addGestureRecognizer(gesture)
//        view.isUserInteractionEnabled = false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let viewclss = touch.view, viewclss.isKind(of: ActionItemCell.self) else {
            return true
        }
        return false
    }
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(gestureRecognizer.delegate)
//
//        print(gestureRecognizer.view.self)
//        return false
//    }
    @objc func outterOutletTouched(){
        print("outter touched")
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Action>(collectionView: listAction) { collectionView,indexPath,action in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionItemCell.reuseIdentifier, for: indexPath) as! ActionItemCell
            cell.config(with: action)
            return cell
        }
    }
    
    func reloadDataset() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Action>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.getActions(), toSection: 0)
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
        listAction.delegate = self
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

extension ASPopUpViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionItemCell.reuseIdentifier, for: indexPath) as! ActionItemCell
        performSegue(withIdentifier: viewModel.getActions()[indexPath.row].segueId, sender: self)
        outterOutletTouched()
    }
}
