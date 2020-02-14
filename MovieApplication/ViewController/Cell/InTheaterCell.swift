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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        showMovieDetail(for: movie.id)
    }
    
    @IBAction func showMoreMovie(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(identifier: "MovieListNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieListViewController
        vc.isMovie = true
        nvc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(nvc, animated: true, completion: nil)
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
    
    func showMovieDetail(for id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(identifier: "MovieDetailNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieDetailViewController
        vc.movieid = id
        nvc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(nvc, animated: true, completion: nil)
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
        if let backdrop = movie.backdrop {
            cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
        }
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
