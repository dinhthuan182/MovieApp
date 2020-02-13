//
//  MoviesViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

struct cellData {
    let cellId: Int
    let title: String
}

class MoviesViewController: UIViewController {
    let networkManager = NetworkManager()
    let onTVCell = "onTVCell"
    let cellDatas = [cellData(cellId: 1, title: "On TV"),
                     cellData(cellId: 2, title: "In Theaters"),
                     cellData(cellId: 3, title: "Featured List")]
    
    @IBOutlet weak var tblMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMovies.rowHeight = UITableView.automaticDimension
        tblMovies.separatorColor = .clear
        
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellDatas[indexPath.row].cellId == 1 {
            let cell = Bundle.main.loadNibNamed("OnTVCell", owner: self, options: nil)?.first as! OnTVCell
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
        } else if cellDatas[indexPath.row].cellId == 2 {
            let cell = Bundle.main.loadNibNamed("InTheaterCell", owner: self, options: nil)?.first as! InTheaterCell
            networkManager.getMoviesInTheater(page: 1) { (movies, error) in
                if let error = error {
                    print(error)
                }
                if let data = movies {
                    cell.movies = Array(data.prefix(3))
                    cell.handleReloadData()
                }
            }
            cell.collectionViewSetup()
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("FeaturedCell", owner: self, options: nil)?.first as! FeaturedCell
            networkManager.getFeatureds(page: 1) { (movies, error) in
                if let error = error {
                    print(error)
                }
                if let data = movies {
                    cell.movies = Array(data.prefix(3))
                    cell.handleReloadData()
                }
            }
            cell.collectionViewSetup()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellDatas[indexPath.row].cellId == 3 {
            return tableView.frame.height * 2.5 / 3
        }
        return tableView.frame.height + 50
    }
}
