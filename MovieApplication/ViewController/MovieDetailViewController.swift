//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit
import AVFoundation

class MovieDetailViewController: UITableViewController {
    var movieid: Int = 0
    var isMovie = true
    lazy var movie = Movie.init()
    lazy var television = Television.init()
    let networkManager = NetworkManager()
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var bubbleView: UIView?
    var vTrailerContainer: UIView?
    var btnCloseTrailer: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close_icon"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell
        self.tableView.register(HeaderMovieDetailCell.nib, forCellReuseIdentifier: HeaderMovieDetailCell.identifier)
        self.tableView.register(InfoMovieDetailCell.nib, forCellReuseIdentifier: InfoMovieDetailCell.identifier)
        self.tableView.register(CastMovieDetailCell.nib, forCellReuseIdentifier: CastMovieDetailCell.identifier)
        
        // Load information for movie
        getMovieInfo()
        
        setupNavigationBar()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderMovieDetailCell.identifier, for: indexPath) as! HeaderMovieDetailCell
            cell.delegate = self
            
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
            
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoMovieDetailCell.identifier, for: indexPath) as! InfoMovieDetailCell

            if isMovie {
                cell.tvOverview.text = movie.overview
                networkManager.getMovieCredits(id: movieid) { (data, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let credit = data {
                        cell.crews = credit.crew
                        cell.handleReloadData()
                    }
                }
            }else {
                cell.tvOverview.text = television.overview
                networkManager.getTelevisionCredits(id: movieid) { (data, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let credit = data {
                        cell.crews = credit.crew
                        cell.handleReloadData()
                    }
                }
            }
            cell.setupView()
            return cell
            
        }else {
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

extension MovieDetailViewController: HeaderCellDelagate {
    func playTrailer(for key: String) {
        let videoUrl = URL(string: "https://www.youtube.com/watch?v=\(key)")
        player = AVPlayer(url: videoUrl!)
        playerLayer = AVPlayerLayer(player: player)
        
        if let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first {
            
            vTrailerContainer = UIView(frame: keyWindow.frame)
            vTrailerContainer?.backgroundColor = .black
            vTrailerContainer?.alpha = 0
            
            btnCloseTrailer.isHidden = false
            //btnCloseTrailer?.tintColor = .white
            btnCloseTrailer.frame = CGRect(x: keyWindow.frame.width - 50, y: 20, width: 30, height: 30)
            btnCloseTrailer.addTarget(self, action: #selector(handleZoomOut(tapGuesture:)), for: .touchUpInside)
            //btnCloseTrailer?.backgroundColor = .red
            bubbleView = UIView(frame: CGRect(x: 0, y: keyWindow.frame.height / 3, width: keyWindow.frame.width, height: 250))
            playerLayer?.frame = bubbleView!.frame
            bubbleView!.layer.addSublayer(playerLayer!)
            
            keyWindow.addSubview(vTrailerContainer!)
            keyWindow.addSubview(btnCloseTrailer)
            keyWindow.addSubview(bubbleView!)
            print(btnCloseTrailer.frame)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.vTrailerContainer?.alpha = 1
                self.btnCloseTrailer.alpha = 1
                self.player?.play()
            }, completion: nil)
        }
    }
    
    @objc func handleZoomOut(tapGuesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.vTrailerContainer?.alpha = 0
            self.btnCloseTrailer.isHidden = true
            self.bubbleView?.alpha = 0
        }, completion: nil)
    }
}
