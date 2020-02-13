//
//  InTheaterCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class InTheaterCell: UITableViewCell {
    private let movieCell = "movieCell"
    var movies = [Movie]()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cltInTheaterMovie: UICollectionView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func collectionViewSetup() {
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.cltInTheaterMovie.register(nib, forCellWithReuseIdentifier: movieCell)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        cltInTheaterMovie.collectionViewLayout = flowLayout
        cltInTheaterMovie.delegate = self
        cltInTheaterMovie.dataSource = self
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.cltInTheaterMovie.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension InTheaterCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: movie.backdrop)
        cell.lblTitle.text = movie.title
        cell.lblSubTitle.text = movie.title
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension InTheaterCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3 - 5)
    }
}
