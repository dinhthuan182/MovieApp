//
//  FeaturedCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class FeaturedCell: UITableViewCell {

    // MARK: - @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cltFeatureMovie: UICollectionView!
    
    // MARK: - properties
    var lists = [ListApiResponse]()
    
    // MARK: - static properties
    static var identifier: String{
        return String(describing: FeaturedCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func collectionViewSetup() {
        self.cltFeatureMovie.register(FeatureMovieCell.nib, forCellWithReuseIdentifier: FeatureMovieCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        
        cltFeatureMovie.reloadData()
        cltFeatureMovie.collectionViewLayout = flowLayout
        cltFeatureMovie.delegate = self
        cltFeatureMovie.dataSource = self
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.cltFeatureMovie.reloadData()
        }
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FeaturedCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureMovieCell.identifier, for: indexPath) as! FeatureMovieCell
        let list = lists[indexPath.row]
        cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: list.posterPath)

        cell.lblTitle.text = list.name
        cell.tvDesc.text = list.description
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeaturedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3 - 10)
    }
}
