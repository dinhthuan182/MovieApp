//
//  OnTVCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class OnTVCell: UITableViewCell {
    
    private let movieCell = "movieCell"
    var televisions = [Television]()
    
    @IBOutlet weak var cltMovie: UICollectionView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func collectionViewSetup() {
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.cltMovie.register(nib, forCellWithReuseIdentifier: movieCell)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        cltMovie.collectionViewLayout = flowLayout
        cltMovie.dataSource = self
        cltMovie.delegate = self
    }
    
    @IBAction func showMoreMovie(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MovieListNavigationViewController")
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.cltMovie.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension OnTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return televisions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell, for: indexPath as IndexPath) as! MovieCell
        let tv = televisions[indexPath.row]
        cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: tv.backdrop)
        cell.lblTitle.text = tv.name
        cell.lblSubTitle.text = tv.originalName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tv = televisions[indexPath.row]
        showMovieDetail(for: tv.id)
    }
    
    func showMovieDetail(for id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.movieid = id
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3 - 5)
    }
}

