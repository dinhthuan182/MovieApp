//
//  InTheaterCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class InTheaterCell: UITableViewCell {

    // MARK: - @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cltInTheaterMovie: UICollectionView!
    
    // MARK: - properties
    var movies = [Movie]()
    var delegate: MovieDetailDelegate?
    // MARK: - static properties
    static var identifier: String{
        return String(describing: InTheaterCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        delegate?.showMovieDetail(for: movie.id, isMovie: true)
    }
    
    @IBAction func showMoreMovie(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let nvc = storyboard.instantiateViewController(withIdentifier: "MovieListNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieListViewController
        vc.isMovie = true
        nvc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(nvc, animated: true, completion: nil)
    }
    
    func collectionViewSetup() {
        self.cltInTheaterMovie.register(MovieCell.nib, forCellWithReuseIdentifier: MovieCell.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
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
