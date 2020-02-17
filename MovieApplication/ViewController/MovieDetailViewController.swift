//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
    var movieid: Int = 0
    var isMovie = true
    lazy var movie = Movie.init()
    lazy var television = Television.init()
    let networkManager = NetworkManager()
    let cellArea = [cellData(cellId: 1, title: "Header"),
                    cellData(cellId: 2, title: "Overview"),
                    cellData(cellId: 3, title: "Cast"),
                    cellData(cellId: 4, title: "Social")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load information for movie
        getMovieInfo()
        
        setupNavigationBar()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellArea.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellArea[indexPath.row].cellId == 1 {
            let cell = Bundle.main.loadNibNamed("HeaderMovieDetailCell", owner: self, options: nil)?.first as! HeaderMovieDetailCell
            if isMovie {
                if let backdrop = movie.backdrop {
                    cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
                }
                
                if let poster = movie.posterPath {
                    cell.imgPoster.loadImageUsingCacheWithUrlString(imgName: poster)
                }
                
                cell.lblTitle.text = movie.title
            }else {
                if let backdrop = television.backdrop {
                    cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
                }
                
                if let poster = television.posterPath {
                    cell.imgPoster.loadImageUsingCacheWithUrlString(imgName: poster)
                }
                
                cell.lblTitle.text = television.name
            }
            return cell
            
        }else if cellArea[indexPath.row].cellId == 2 {
            let cell = Bundle.main.loadNibNamed("InfoMovieDetailCell", owner: self, options: nil)?.first as! InfoMovieDetailCell
            if isMovie {
               cell.tvOverview.text = movie.overview
            }else {
                cell.tvOverview.text = television.overview
            }
            cell.setupView()
            return cell
            
        }else if cellArea[indexPath.row].cellId == 3 {
            let cell = Bundle.main.loadNibNamed("CastMovieDetailCell", owner: self, options: nil)?.first as! CastMovieDetailCell
            if isMovie {
                networkManager.getMovieCredits(id: movieid) { (data, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let credit = data {
                        cell.cast = credit.cast
                        cell.handleReloadData()
                    }
                }
            }else {
                networkManager.getTelevisionCredits(id: movieid) { (data, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let credit = data {
                        cell.cast = credit.cast
                        cell.handleReloadData()
                    }
                }
            }
            
            cell.collectionViewSetup()
            return cell
            
        }else {
            let cell = Bundle.main.loadNibNamed("SocialMovieDetailCell", owner: self, options: nil)?.first as! SocialMovieDetailCell
            cell.setupView()
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setupNavigationBar() {
        // Setup back button
        let btnBack = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left"), style: .plain, target: self, action: #selector(backtoBeforeView))
        btnBack.tintColor = .gray
        self.navigationItem.leftBarButtonItem = btnBack
    }
    
    @objc func backtoBeforeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getMovieInfo() {
        if isMovie {
            networkManager.getMovieInfomation(id: movieid) { (movie, error) in
                if let err = error {
                    print(err)
                }
                
                if let movie = movie {
                    self.movie = movie
                    self.handleReloadData()
                }
            }
        }else {
            networkManager.getTelevisonInfomation(id: movieid) { (television, error) in
                if let err = error {
                    print(err)
                }
                
                if let tv = television {
                    self.television = tv
                    self.handleReloadData()
                }
            }
        }
    }
}
