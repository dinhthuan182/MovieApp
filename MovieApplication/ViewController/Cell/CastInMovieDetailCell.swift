//
//  CastInMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class CastInMovieDetailCell: UICollectionViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblEpisodes: UILabel!
    
    // MARK: - properties
    var cast: Cast? {
        didSet {
            self.lblName.text = cast?.name
            self.lblSubTitle.text = cast?.character
        }
    }
    
    //MARK: - static properties
    static var identifier: String{
        return String(describing: CastInMovieDetailCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
