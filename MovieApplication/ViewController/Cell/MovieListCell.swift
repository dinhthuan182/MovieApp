//
//  MovieListCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/24/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var imgBackDrop: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblData: UILabel!
    
    // MARK: - properties
    var movie: Movie? {
        didSet {
            if let backdrop = movie?.backdrop {
                self.imgBackDrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
            }
            self.lblTitle.text = movie?.title
            self.lblData.text = "Release: " + movie!.releaseDate
        }
    }
    
    var tv: Television? {
        didSet {
            if let backdrop = tv?.backdrop {
                self.imgBackDrop.loadImageUsingCacheWithUrlString(imgName: backdrop)
            }
            self.lblTitle.text = tv?.name
            self.lblData.text = "First Air: " + tv!.firstAirDate
        }
    }
    
    // MARK: - static properties
    static var identifier: String {
        return String(describing: MovieListCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
