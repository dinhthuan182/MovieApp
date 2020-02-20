//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
    
    // MARK: - properties
    var movieid: Int = 0
    var isMovie = true
    lazy var movie = Movie.init()
    lazy var television = Television.init()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell
        self.tableView.register(HeaderMovieDetailCell.nib, forCellReuseIdentifier: HeaderMovieDetailCell.identifier)
        self.tableView.register(InfoMovieDetailCell.nib, forCellReuseIdentifier: InfoMovieDetailCell.identifier)
        self.tableView.register(CrewMovieCell.nib, forCellReuseIdentifier: CrewMovieCell.identifier)
        self.tableView.register(CastMovieDetailCell.nib, forCellReuseIdentifier: CastMovieDetailCell.identifier)
        // Set auto size for cell
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        // Load information for movie
        getMovieInfo()
        // Set navigation abr
        setupNavigationBar()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Header Cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderMovieDetailCell.identifier, for: indexPath) as! HeaderMovieDetailCell
            cell.delegate = self
            
            // Check if is movie will load data of movie else load data from television
            if isMovie {
                if let backdrop = movie.backdrop {
                    cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
                }
                
                if let poster = movie.posterPath {
                    cell.imgPoster.loadImageUsingCacheWithUrlString(imgName: poster)
                }
                
                cell.lblTitle.text = movie.title
                
            } else {
                if let backdrop = television.backdrop {
                    cell.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
                }
                
                if let poster = television.posterPath {
                    cell.imgPoster.loadImageUsingCacheWithUrlString(imgName: poster)
                }
                
                cell.lblTitle.text = television.name
                
            }
            return cell
        
        // Overview cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoMovieDetailCell.identifier, for: indexPath) as! InfoMovieDetailCell

            if isMovie {
                cell.tvOverview.text = movie.overview
            } else {
                cell.tvOverview.text = television.overview
            }
            
            cell.setupView()
            return cell
           
        // Featured cell
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CrewMovieCell.identifier, for: indexPath) as! CrewMovieCell
            
            if isMovie {
                networkManager.getMovieCredits(id: movieid) { (data, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let credit = data {
                        cell.filterCrew = self.filterCrewData(crews: credit.crew)
                        cell.handleReloadData()
                    }
                }
            } else {
                networkManager.getTelevisionCredits(id: movieid) { (data, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let credit = data {
                        cell.filterCrew = self.filterCrewData(crews: credit.crew)
                        cell.handleReloadData()
                    }
                }
            }
            cell.setupView()
            return cell
        
        // Cast cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastMovieDetailCell.identifier, for: indexPath) as! CastMovieDetailCell
            
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
            } else {
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
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setupNavigationBar() {
        // Setup back button
        let btnBack = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(backtoBeforeView))
        btnBack.tintColor = .gray
        self.navigationItem.leftBarButtonItem = btnBack
    }
    
    @objc func backtoBeforeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Reload for tableview
    func handleReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Get infomation of movie or televison
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
    
    // Filter Crew data loaded
    func filterCrewData(crews: [Crew]) -> [Crew]{
        var filterCrew = [Crew]()
        for crew in crews {
            var flag = false
            for item in filterCrew {
                if crew.job == item.job {
                    flag = true
                }
            }
            
            if !flag {
                filterCrew.append(crew)
            }
            
            if filterCrew.count >= 10 {
                break
            }
        }
        return filterCrew
    }
}


// MARK: - HeaderCellDelagate
extension MovieDetailViewController: HeaderCellDelagate {
    func playTrailer() {
        if isMovie {
            networkManager.getMovieTrailer(for: movieid) { (response, error) in
                if let err = error {
                    print(err)
                }
                if let video = response?.videos.first {
                    self.showVideo(for: video.key)
                }
            }
        } else {
            networkManager.getTelevisonTrailer(for: movieid) { (response, error) in
                if let err = error {
                    print(err)
                }
                if let video = response?.videos.first {
                    self.showVideo(for: video.key)
                }
            }
        }
    }
    
    func showVideo(for key: String)  {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
            vc.videoKey = key
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}


// MARK: - CastDelegate
extension MovieDetailViewController: CastDelegate {
    func showPersonDetail(person: Person) {
        let controller = PersonDetailViewController()
        controller.person = person
        self.present(controller, animated: true)
    }
}

