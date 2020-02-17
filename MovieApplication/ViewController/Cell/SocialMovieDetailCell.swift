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
    @IBOutlet weak var tblDiscussion: UITableView!
    @IBOutlet weak var vReview: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vReview.alpha = 0
        tblDiscussion.register(DiscussionCell.nib, forCellReuseIdentifier: DiscussionCell.identifier)
        tblDiscussion.rowHeight = UITableView.automaticDimension
        tblDiscussion.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func switchSocialTab(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tblDiscussion.alpha = 1
            vReview.alpha = 0
        }else {
            tblDiscussion.alpha = 0
            vReview.alpha = 1
        }
    }
}

extension SocialMovieDetailCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscussionCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
