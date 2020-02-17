//
//  DiscussionCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/17/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class DiscussionCell: UITableViewCell {
    
    static var identifier: String{
        return String(describing: DiscussionCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblDiscussion: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
