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
    
    @IBOutlet var tblMovie: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getAiringTodayTV(page: 1) { (televisons, error) in
            if let error = error {
                print(error)
            }
            
            if let televisons = televisons {
                self.televisonList = televisons
                self.handleReloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(televisonList.count)
        return televisonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListCellId, for: indexPath) as! MovieListCell
        let tv = televisonList[indexPath.row]
        cell.imgBackDrop.loadImageUsingCacheWithUrlString(imgName: tv.backdrop)
        cell.lblTitle.text = tv.name
        cell.lblDate.text = "First air date: " + tv.firstAirDate
        return cell
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.tblMovie.reloadData()
        }
    }
}
