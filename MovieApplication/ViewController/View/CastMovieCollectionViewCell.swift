//
//  CastMovieCollectionViewCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/4/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class CastMovieCollectionViewCell: UICollectionViewCell {
    let imgActor: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        img.backgroundColor = .cyan
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var cast: Cast? {
        didSet {
            if let profile = cast?.profilePath {
                let urlString = Api.general.getImageLink(profile)
                self.imgActor.loadImageUsingCacheWithUrlString(imgName: urlString)
            }
        }
    }
    
    func setupView() {
        self.addSubview(imgActor)
        NSLayoutConstraint.activate([
            imgActor.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgActor.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imgActor.widthAnchor.constraint(equalToConstant: 100),
            imgActor.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
