//
//  PersonCollectionViewCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    let imgPerson: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .cyan
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblPersonName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupView() {
        self.addSubview(imgPerson)
        self.addSubview(lblPersonName)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(srgbRed: 41, green: 41, blue: 51, alpha: 1)
        // Autolayout for imgMovie
        NSLayoutConstraint.activate([
            imgPerson.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgPerson.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imgPerson.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imgPerson.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85)
        ])
        
        // Autolayout for lblMovieName
        NSLayoutConstraint.activate([
            lblPersonName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lblPersonName.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lblPersonName.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            lblPersonName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15)
            
        ])
    }
    
    var person: Person? {
        didSet {
            self.setupBackDrop()
            self.lblPersonName.text = person?.name
        }
    }
    
    private func setupBackDrop() {
        if let backdrop = person?.profilePath {
            let urlString = Api.general.getImageLink(backdrop)
            self.imgPerson.loadImageUsingCacheWithUrlString(urlString: urlString)
        }
    }
}
