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
    lazy var movie = Movie.init()
    let networkManager = NetworkManager()
    let cellArea = [cellData(cellId: 1, title: "Header"),
                    cellData(cellId: 2, title: "Overview"),
                    cellData(cellId: 3, title: "Cast"),
                    cellData(cellId: 4, title: "Season"),
                    cellData(cellId: 5, title: "Social")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load information for movie
        networkManager.getMovieInfomation(id: movieid) { (movie, error) in
            if let err = error {
                print(err)
            }
            
            if let movie = movie {
                self.movie = movie
            }
        }
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
            cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: movie.backdrop)
            cell.imgPoster.loadImageUsingCacheWithUrlString(imgName: movie.posterPath)
            cell.lblTitle.text = movie.title
            return cell
        }else if cellArea[indexPath.row].cellId == 2 {
            let cell = Bundle.main.loadNibNamed("InfoMovieDetailCell", owner: self, options: nil)?.first as! InfoMovieDetailCell
            return cell
        }else if cellArea[indexPath.row].cellId == 3 {
            let cell = Bundle.main.loadNibNamed("CastMovieDetailCell", owner: self, options: nil)?.first as! CastMovieDetailCell
            return cell
        }else if cellArea[indexPath.row].cellId == 4 {
            let cell = Bundle.main.loadNibNamed("SeasonInMovieDetailCell", owner: self, options: nil)?.first as! SeasonInMovieDetailCell
            return cell
        }else {
            let cell = Bundle.main.loadNibNamed("SocialMovieDetailCell", owner: self, options: nil)?.first as! SocialMovieDetailCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return tableView.frame.height * 0.52
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
}
