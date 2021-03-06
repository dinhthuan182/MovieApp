//
//  OnTVCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class OnTVCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var cltMovie: UICollectionView!
    
    // MARK: - properties
    var televisions = [Television]()
    
    // MARK: - static properties
    static var identifier: String {
        return String(describing: OnTVCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func showMoreMovie(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(withIdentifier: "MovieListNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieListViewController
        vc.isMovie = false
        nvc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(nvc, animated: true, completion: nil)
    }
    
    func collectionViewSetup() {
        self.cltMovie.register(MovieCell.nib, forCellWithReuseIdentifier: MovieCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        cltMovie.collectionViewLayout = flowLayout
        cltMovie.dataSource = self
        cltMovie.delegate = self
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath as IndexPath) as! MovieCell
        let tv = televisions[indexPath.row]
        if let backdrop = tv.backdrop {
            cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
        }
        
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
        let nvc = storyboard.instantiateViewController(withIdentifier: "MovieDetailNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieDetailViewController
        vc.movieid = id
        vc.isMovie = false
        nvc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(nvc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3 - 5)
    }
}

