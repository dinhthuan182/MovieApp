//
//  FeaturedCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class FeaturedCell: UITableViewCell {
    private let featureCell = "featureMovieCell"
    var movies = [Movie]()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cltFeatureMovie: UICollectionView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func collectionViewSetup() {
        let nib = UINib(nibName: "FeatureMovieCell", bundle: nil)
        self.cltFeatureMovie.register(nib, forCellWithReuseIdentifier: featureCell)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
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
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureCell, for: indexPath) as! FeatureMovieCell
        let movie = movies[indexPath.row]
        if let backdrop = movie.backdrop {
            cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
        }
        cell.lblTitle.text = movie.title
        cell.tvDesc.text = movie.overview
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeaturedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3 - 10)
    }
}
