//
//  GenresCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class GenresCell: UICollectionViewCell {
    var selectedFlag: Bool? {
        didSet {
            imgSelected.image = UIImage(named: "")
        }
    }
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let imgSelected: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
}
