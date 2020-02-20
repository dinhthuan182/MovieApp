//
//  InfoMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class InfoMovieDetailCell: UITableViewCell, UITextViewDelegate {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var tvOverview: UITextView!
    
    // MARK: - static properties
    static var identifier: String{
        return String(describing: InfoMovieDetailCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView() {
        tvOverview.delegate = self
    }
    
}

