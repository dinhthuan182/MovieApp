//
//  MovieCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/11/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    // MARK: - static properties
    static var identifier: String{
        return String(describing: MovieCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
