//
//  CrewMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/18/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class CrewMovieDetailCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    // MARK: - properties
    var crew: Crew? {
        didSet {
            self.lblTitle.text = crew?.name
            self.lblSubTitle.text = crew?.job
        }
    }
    
    // MARK: - static properties
    static var identifier: String {
        return String(describing: CrewMovieDetailCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
