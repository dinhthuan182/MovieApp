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
    var currentPage = 1
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
    @IBOutlet var tblMovie: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get movie
        networkManager.getAiringTodayTV(page: currentPage) { (responseData, error) in
            if let error = error {
                print(error)
            }
            
            if let responseData = responseData {
                self.televisonList = responseData.televisions
                self.handleReloadData()
            }
        }
        activityIndicator = LoadMoreActivityIndicator(scrollView: tblMovie, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
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

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator.start {
            self.networkManager.getAiringTodayTV(page: self.currentPage + 1) { (responseData, error) in
                if let error = error {
                    print(error)
                }
                
                if let data = responseData {
                    self.televisonList.append(contentsOf: data.televisions)
                    self.currentPage += 1
                    self.handleReloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMovieDetail()
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
    
    func showMovieDetail() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailNavigationViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
