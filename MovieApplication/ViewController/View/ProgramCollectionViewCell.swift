//
//  ProgramCollectionViewCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class ProgramCollectionViewCell: UICollectionViewCell {
    let imgProgram: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .cyan
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblProgramName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupView() {
        self.addSubview(imgProgram)
        self.addSubview(lblProgramName)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(srgbRed: 41, green: 41, blue: 51, alpha: 1)
        // Autolayout for imgMovie
        NSLayoutConstraint.activate([
            imgProgram.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgProgram.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imgProgram.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imgProgram.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85)
        ])
        
        // Autolayout for lblMovieName
        NSLayoutConstraint.activate([
            lblProgramName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lblProgramName.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lblProgramName.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            lblProgramName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15)
            
        ])
    }
    
    var program: Program? {
        didSet {
            self.setupBackDrop()
            self.lblProgramName.text = program?.name
        }
    }
    
    private func setupBackDrop() {
        if let backdrop = program?.posterPath {
            let urlString = Api.general.getImageLink(backdrop)
            self.imgProgram.loadImageUsingCacheWithUrlString(imgName: urlString)
        }
        
    }
}
