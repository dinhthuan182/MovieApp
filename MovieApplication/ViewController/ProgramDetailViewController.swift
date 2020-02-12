//
//  ProgramDetailViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/4/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class ProgramDetailViewController: UIViewController {
    private let actorCellId = "actorCellId"
    var casts = [Cast]()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: UIScreen.main.bounds)
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
        
    }()
    
    let imgBackdrop: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgPoster: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lblGenres: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblRated: UILabel = {
        let lbl = UILabel()
        lbl.text = "☆☆☆☆☆"
        lbl.textColor = .orange
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customRGB(222, 222, 222, 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tvOverView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let separatorLineAfter: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customRGB(222, 222, 222, 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var clvCredits: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.register(CastMovieCollectionViewCell.self, forCellWithReuseIdentifier: "actorCellId")
        clv.backgroundColor = .white
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
    }()
    
    var program: Program? {
        didSet {
            //getListActor(at: program!.id)
            //var genreString = ""
            var ratedString = ""
            // Setup image Backdrop
            if let backdrop = program?.backdropPath {
                let urlString = Api.general.getImageLink(backdrop)
                self.imgBackdrop.loadImageUsingCacheWithUrlString(imgName: urlString)
            }
            
            // Setup image poster
            if let poster = program?.posterPath {
                let urlString = Api.general.getImageLink(poster)
                self.imgPoster.loadImageUsingCacheWithUrlString(imgName: urlString)
            }
            
            self.lblTitle.text = program?.name
            
            // Setup genre list
//            if let genres = program?.genres {
//                for (index, genre) in genres.enumerated() {
//                    if index == genres.endIndex - 1 {
//                        genreString += genre.name
//                        break
//                    }
//                    genreString += ( genre.name + ", " )
//                }
//            }
            
            //self.lblGenres.text = genreString
            
            // Setup reated
            if let rated = program?.voteAverage {
                for i in 1...5 {
                    if i < Int(rated / 2) {
                        ratedString += "★"
                    } else {
                        ratedString += "☆"
                    }
                }
            }
            self.lblRated.text = ratedString
            
            
            self.tvOverView.text = program?.overview
            let height = estimateFrameForText(text: program!.overview!).height
            self.tvOverView.frame = CGRect(x: tvOverView.frame.origin.x, y: tvOverView.frame.origin.y, width: tvOverView.frame.width, height: height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupCollectionView()
        
        clvCredits.delegate = self
        clvCredits.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frame = view.bounds
        scrollView.frame = frame
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height + 10)
    }
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(imgBackdrop)
        scrollView.addSubview(vContent)
        
        vContent.addSubview(imgPoster)
        vContent.addSubview(lblTitle)
        vContent.addSubview(lblGenres)
        vContent.addSubview(lblRated)
        vContent.addSubview(separatorLine)
        vContent.addSubview(tvOverView)
        vContent.addSubview(separatorLineAfter)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imgBackdrop.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imgBackdrop.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            imgBackdrop.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imgBackdrop.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.35)
        ])

        NSLayoutConstraint.activate([
            vContent.topAnchor.constraint(equalTo: imgBackdrop.bottomAnchor, constant: 10),
            vContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            vContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            vContent.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            imgPoster.topAnchor.constraint(equalTo: vContent.topAnchor),
            imgPoster.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            imgPoster.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.35),
            imgPoster.heightAnchor.constraint(equalTo: vContent.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: vContent.topAnchor),
            lblTitle.leftAnchor.constraint(equalTo: imgPoster.rightAnchor, constant: 8),
            lblTitle.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            lblGenres.topAnchor.constraint(equalTo: lblTitle.bottomAnchor),
            lblGenres.leftAnchor.constraint(equalTo: imgPoster.rightAnchor, constant: 8),
            lblGenres.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            lblRated.topAnchor.constraint(equalTo: lblGenres.bottomAnchor),
            lblRated.leftAnchor.constraint(equalTo: imgPoster.rightAnchor, constant: 8),
            lblRated.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: imgPoster.bottomAnchor, constant: 15),
            separatorLine.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            separatorLine.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        let overviewHeight = estimateFrameForText(text: program!.overview!).height + 35
        NSLayoutConstraint.activate([
            tvOverView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 5),
            tvOverView.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            tvOverView.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            tvOverView.heightAnchor.constraint(equalToConstant: overviewHeight)
        ])
        
        NSLayoutConstraint.activate([
            separatorLineAfter.topAnchor.constraint(equalTo: tvOverView.bottomAnchor),
            separatorLineAfter.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            separatorLineAfter.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            separatorLineAfter.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func setupCollectionView() {
        vContent.addSubview(clvCredits)
        
        NSLayoutConstraint.activate([
            clvCredits.topAnchor.constraint(equalTo: separatorLineAfter.bottomAnchor, constant: 10),
            clvCredits.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            clvCredits.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            clvCredits.heightAnchor.constraint(equalToConstant: 100)
        ])

    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let screenSize = UIScreen.main.bounds
        let size = CGSize(width: screenSize.width, height: screenSize.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], context: nil)
    }
    
    
    func handleReloadCollection() {
        DispatchQueue.main.async {
            //reload data of message collection
            self.clvCredits.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension ProgramDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: actorCellId, for: indexPath) as! CastMovieCollectionViewCell
        let cast = casts[indexPath.row]
        cell.setupView()
        cell.cast = cast
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.height)
    }
}
