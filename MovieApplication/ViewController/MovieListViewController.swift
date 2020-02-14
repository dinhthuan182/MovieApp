//
//  MovieListViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/12/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieListViewController: UITableViewController {
    let networkManager = NetworkManager()
    let movieListCellId = "MovieListCell"
    var televisonList = [Television]()
    var movieList = [Movie]()
    var isMovie = true
    var currentPage = 1
    var totalPage = 1
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
    @IBOutlet var tblMovie: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(page: currentPage)
        activityIndicator = LoadMoreActivityIndicator(scrollView: tblMovie, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isMovie {
            return movieList.count
        }else {
            return televisonList.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListCellId, for: indexPath) as! MovieListCell
        if isMovie {
            let movie = movieList[indexPath.row]
            if let backdrop = movie.backdrop {
                cell.imgBackDrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
            }
            cell.lblTitle.text = movie.title
            cell.lblDate.text = "First air date: " + movie.releaseDate
        }else {
            let tv = televisonList[indexPath.row]
            if let backdrop = tv.backdrop {
               cell.imgBackDrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
            }
            
            cell.lblTitle.text = tv.name
            cell.lblDate.text = "First air date: " + tv.firstAirDate
        }
        
        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if totalPage > currentPage {
            activityIndicator.start {
                self.getData(page: self.currentPage + 1)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isMovie {
            let movie = movieList[indexPath.row]
            showMovieDetail(id: movie.id)
        }else {
            let tv = televisonList[indexPath.row]
            showMovieDetail(id: tv.id)
        }
        
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.tblMovie.reloadData()
            self.activityIndicator.stop()
        }
    }
    
    func setupNavigationBar() {
        // Setup back button
        let btnBack = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left"), style: .plain, target: self, action: #selector(backtoBeforeView))
        btnBack.tintColor = .gray
        self.navigationItem.title = "On TV"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        self.navigationItem.leftBarButtonItem = btnBack
    }
    
    @objc func backtoBeforeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showMovieDetail(id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(identifier: "MovieDetailNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieDetailViewController
        vc.movieid = id
        nvc.modalPresentationStyle = .fullScreen
        self.present(nvc, animated: true)
    }
    
    func getData(page: Int) {
        if isMovie {
            // Get movie
            networkManager.getMoviesInTheater(page: page) { (responseData, error) in
                if let error = error {
                    print(error)
                }
                
                if let responseData = responseData {
                    self.movieList.append(contentsOf: responseData.movies)
                    self.currentPage = responseData.page
                    self.totalPage = responseData.numberOfPages
                    self.handleReloadData()
                }
            }
        }else {
            // Get movie
            networkManager.getAiringTodayTV(page: page) { (responseData, error) in
                if let error = error {
                    print(error)
                }
                
                if let responseData = responseData {
                    self.televisonList.append(contentsOf: responseData.televisions)
                    self.currentPage = responseData.page
                    self.totalPage = responseData.numberOfPages
                    self.handleReloadData()
                }
            }
        }
        
    }
}
