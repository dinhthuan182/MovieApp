//
//  SocialMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class SocialMovieDetailCell: UITableViewCell {

    static var identifier: String{
        return String(describing: SocialMovieDetailCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var smcSocial: UISegmentedControl!
    @IBOutlet weak var vSocialContainer: UIView!
    
    var views = [UIView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func switchSocialTab(_ sender: UISegmentedControl) {
        vSocialContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
    func setupView() {
        views.append(DiscussionViewController().view)
        views.append(ReviewViewController().view)
        
        for v in views {
            vSocialContainer.addSubview(v)
        }
        vSocialContainer.bringSubviewToFront(views[0])
    }
}
