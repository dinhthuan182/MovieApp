//
//  MoviesCollectionViewController.swift
//  MovieApplication
//
//  Created by Catalina on 1/31/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit
import Alamofire

class MoviesCollectionViewController: UICollectionViewController {
    private let MoviesCellId = "moviesCellId"
    let cellSpacing: CGFloat = 5
    var topMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCellId)
        self.getListMovie()
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: cellSpacing, bottom: 0, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return topMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCellId, for: indexPath) as! MovieCollectionViewCell
        cell.setupView()
        let movie = topMovies[indexPath.row]
        cell.movie = movie

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = topMovies[indexPath.row]
        guard let movieId = movie.id else {
            return
        }
        
        Api.movie.getMovieDetail(with: movieId, onSuccess: { (movie) in
            self.showMovieDetail(movie: movie)
        }, onError: { (error) in
            print("Load movie detail error: ", error)
        })
        
    }

    func getListMovie() {
        Api.movie.getListMovie(onSuccess: { (topRate) in
            if let top = topRate.results {
                self.topMovies = top
            }
        }) { (error) in
            print("Load movie error:",error)
        }
        handleReloadCollection()
    }
    
    func handleReloadCollection() {
        DispatchQueue.main.async {
            //reload data of message collection
            self.collectionView.reloadData()
        }
    }
    
    func showMovieDetail(movie: Movie) {
        let controller = MovieDetailViewController()
        controller.movie = movie
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        let height = (UIScreen.main.bounds.size.height - 4 * cellSpacing) / 4
        return CGSize(width: width, height: height)
    }
}
