//
//  MovieCollectionViewCell.swift
//  MovieApplication
//
//  Created by Catalina on 1/31/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit
import Alamofire

class MovieCollectionViewCell: UICollectionViewCell {
    let imgMovie: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .cyan
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblMovieName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Iron man Iron man Iron man"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupView() {
        self.addSubview(imgMovie)
        self.addSubview(lblMovieName)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(srgbRed: 41, green: 41, blue: 51, alpha: 1)
        // Autolayout for imgMovie
        NSLayoutConstraint.activate([
            imgMovie.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgMovie.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imgMovie.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imgMovie.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85)
        ])
        
        // Autolayout for lblMovieName
        NSLayoutConstraint.activate([
            lblMovieName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lblMovieName.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lblMovieName.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            lblMovieName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15)
            
        ])
    }
    
    var movie: Movie? {
        didSet {
            self.setupBackDrop()
            self.lblMovieName.text = movie?.title
        }
    }
    
    private func setupBackDrop() {
        if let backdrop = movie?.backdrop_path {
            let urlString = Api.general.getBackDropLink(backdrop)
            self.imgMovie.loadImageUsingCacheWithUrlString(urlString: urlString)
        }
        
    }
}
