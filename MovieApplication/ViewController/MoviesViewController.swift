//
//  MoviesViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

protocol MovieDetailDelegate {
    func showMovieDetail(for id: Int, isMovie: Bool)
}

class MoviesViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var tblTrendingSearchs: UITableView!
    
    // MARK: - properties
    let networkManager = NetworkManager()
    let searchCell = "searchCell"
    var searchs = [Search]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupNavigation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell
        tblMovies.register(OnTVCell.nib, forCellReuseIdentifier: OnTVCell.identifier)
        tblMovies.register(InTheaterCell.nib, forCellReuseIdentifier: InTheaterCell.identifier)
        tblMovies.register(FeaturedCell.nib, forCellReuseIdentifier: FeaturedCell.identifier)
        
        tblMovies.rowHeight = UITableView.automaticDimension
        tblMovies.separatorColor = .clear
        
        tblTrendingSearchs.register(UITableViewCell.self, forCellReuseIdentifier: searchCell)
    }
    
    func setupNavigation() {
        let imgLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgLogo.image = UIImage(named: "logo")
        imgLogo.contentMode = .scaleAspectFit
        navigationItem.titleView = imgLogo
        navigationController?.navigationBar.backgroundColor = UIColor.customRGB(7, 27, 36, 1)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return 3
        } else {
            return searchs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OnTVCell.identifier, for: indexPath) as! OnTVCell
            cell.delegate = self
            
            networkManager.getAiringTodayTV(page: 1) { (responseData, error) in
                if let error = error {
                    print(error)
                }
                if let tvs = responseData?.televisions {
                    cell.televisions = Array(tvs.prefix(3))
                    cell.handleReloadData()
                }
            }
            
            cell.collectionViewSetup()
            return cell
            
        } else if indexPath.row == 1 && tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InTheaterCell.identifier, for: indexPath) as! InTheaterCell
            cell.delegate = self
            
            networkManager.getMoviesInTheater(page: 1) { (responseData, error) in
                if let error = error {
                    print(error)
                }
                if let data = responseData?.movies {
                    cell.movies = Array(data.prefix(3))
                    cell.handleReloadData()
                }
            }
            
            cell.collectionViewSetup()
            return cell
            
        } else if indexPath.row == 2 && tableView.tag == 0 {
            let listId = [932, 2469, 3321]
            let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedCell.identifier, for: indexPath) as! FeaturedCell
            
            for i in listId {
                self.networkManager.getFeatureds(id: i) { (responseData, error) in
                    if let error = error {
                        print(error)
                    }
                    if let data = responseData {
                        cell.lists.append(data)
                    }
                }
            }
            
            cell.handleReloadData()
            cell.collectionViewSetup()
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: searchCell, for: indexPath)
            let search = searchs[indexPath.row]
            cell.textLabel?.text = search.name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0 {
            return tableView.frame.height + 100
        }
        return 30
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bounds = self.tblTrendingSearchs.bounds
        self.tblTrendingSearchs.frame = CGRect(x: bounds.minX, y: bounds.minY + 120, width: bounds.width, height: bounds.height)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.tblTrendingSearchs.frame = CGRect(x: bounds.minX, y: bounds.minY + 120, width: bounds.width, height: CGFloat(0))
        }, completion: nil)
        tblTrendingSearchs.isHidden = true
    }
    
    func reloadSearchData() {
        DispatchQueue.main.async {
            self.tblTrendingSearchs.isHidden = false
            let bounds = self.tblTrendingSearchs.bounds
            let height = self.searchs.count * 30 + 5
            self.tblTrendingSearchs.frame = CGRect(x: bounds.minX, y: bounds.minY + 120, width: bounds.width, height: bounds.height)
            self.tblTrendingSearchs.reloadData()
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.tblTrendingSearchs.frame = CGRect(x: bounds.minX, y: bounds.minY + 120, width: bounds.width, height: CGFloat(height))
            }, completion: nil)
            
        }
    }
}


extension MoviesViewController: MovieDetailDelegate {
    func showMovieDetail(for id: Int, isMovie: Bool) {
        self.tblTrendingSearchs.isHidden = true
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = storyboard.instantiateViewController(withIdentifier: "MovieDetailNavigationViewController") as! UINavigationController
        let vc = nvc.topViewController as! MovieDetailViewController
        vc.movieid = id
        vc.isMovie = isMovie
        nvc.modalPresentationStyle = .fullScreen
        self.present(nvc, animated: true, completion: nil)
    }
}
