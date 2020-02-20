//
//  FeatureMovieCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/12/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class FeatureMovieCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvDesc: UITextView!
    
    // MARK: - static properties
    static var identifier: String{
        return String(describing: FeatureMovieCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
