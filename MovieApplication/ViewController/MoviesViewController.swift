//
//  MoviesViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    let networkManager = NetworkManager()
    
    @IBOutlet weak var tblMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell
        tblMovies.register(OnTVCell.nib, forCellReuseIdentifier: OnTVCell.identifier)
        tblMovies.register(InTheaterCell.nib, forCellReuseIdentifier: InTheaterCell.identifier)
        tblMovies.register(FeaturedCell.nib, forCellReuseIdentifier: FeaturedCell.identifier)
        
        tblMovies.rowHeight = UITableView.automaticDimension
        tblMovies.separatorColor = .clear
        
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OnTVCell.identifier, for: indexPath) as! OnTVCell
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
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InTheaterCell.identifier, for: indexPath) as! InTheaterCell
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedCell.identifier, for: indexPath) as! FeaturedCell
            networkManager.getFeatureds(page: 1) { (movieApiResponse, error) in
                if let error = error {
                    print(error)
                }
                if let data = movieApiResponse?.movies {
                    cell.movies = Array(data.prefix(3))
                    cell.handleReloadData()
                }
            }
            cell.collectionViewSetup()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return tableView.frame.height * 2.5 / 3
        }
        return tableView.frame.height + 50
    }
}
