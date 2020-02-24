//
//  MovieListViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/12/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tblSearchResult: UITableView!
    @IBOutlet weak var tblMovies: UITableView!
    
    // MARK: - properties
    let networkManager = NetworkManager()
    let searchCell = "searchCell"
    var searchs = [Search]()
    var televisonList = [Television]()
    var movieList = [Movie]()
    var isMovie = true
    var currentPage = 1
    var totalPage = 1
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMovies.register(MovieListCell.nib, forCellReuseIdentifier: MovieListCell.identifier)
        getData(page: currentPage)
        activityIndicator = LoadMoreActivityIndicator(scrollView: self.tblMovies, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
        tblSearchResult.register(UITableViewCell.self, forCellReuseIdentifier: searchCell)
    }
    
    func setupNavigationBar() {
        // Setup back button
        let imgLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgLogo.image = UIImage(named: "logo")
        imgLogo.contentMode = .scaleAspectFit
        navigationItem.titleView = imgLogo
        navigationController?.navigationBar.backgroundColor = UIColor.customRGB(7, 27, 36, 1)

        let btnBack = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(backtoBeforeView))
        btnBack.tintColor = .gray
        self.navigationItem.leftBarButtonItem = btnBack
    }
    
    @objc func backtoBeforeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showMovieDetail(id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(withIdentifier: "MovieDetailNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieDetailViewController
        vc.movieid = id
        vc.isMovie = isMovie
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
            
        } else {
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isMovie && tableView.tag == 0 {
            return movieList.count
        } else if !isMovie && tableView.tag == 0 {
            return televisonList.count
        } else {
            return searchs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as! MovieListCell
            
            if isMovie {
                let movie = movieList[indexPath.row]
                cell.movie = movie
                
            } else {
                let tv = televisonList[indexPath.row]
                cell.tv = tv
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: searchCell, for: indexPath)
            let search = searchs[indexPath.row]
            cell.textLabel?.text = search.name
            return cell
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if totalPage > currentPage {
            activityIndicator.start {
                self.getData(page: self.currentPage + 1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isMovie && tableView.tag == 0 {
            let movie = movieList[indexPath.row]
            showMovieDetail(id: movie.id)
        } else if !isMovie && tableView.tag == 0 {
            let tv = televisonList[indexPath.row]
            showMovieDetail(id: tv.id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0 {
            return UITableView.automaticDimension
        }
        return 30
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.tblMovies.reloadData()
            self.activityIndicator.stop()
        }
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkManager.loadKeywordSearch(for: searchText) { (responseData, error) in
            if let error = error {
                print(error)
            }
            if let data = responseData?.results {
                self.searchs = Array(data.prefix(10))
                self.reloadSearchData()
            }
        }
    }
    
    func reloadSearchData() {
        DispatchQueue.main.async {
            let frame = self.tblSearchResult.frame
            let height = CGFloat(self.searchs.count * 30)
            print(self.searchs.count)
            print(frame)
            self.tblSearchResult.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 0)
            self.tblSearchResult.reloadData()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.tblSearchResult.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: height)
            }, completion: nil)
        }
    }
}
