//
//  HeaderMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

protocol HeaderCellDelagate {
    func playTrailer()
}

class HeaderMovieDetailCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var imgBackdrop: UIImageView! 
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - properties
    var delegate: HeaderCellDelagate?
    
    // MARK: - static properties
    static var identifier: String {
        return String(describing: HeaderMovieDetailCell.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func playTrailerClicked(_ sender: Any) {
        delegate?.playTrailer()
    }
}
