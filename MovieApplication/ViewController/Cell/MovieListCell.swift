//
//  MovieListCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/12/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var imgBackDrop: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    // MARK: - static properties
    static var identifier: String{
        return String(describing: MovieListCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
