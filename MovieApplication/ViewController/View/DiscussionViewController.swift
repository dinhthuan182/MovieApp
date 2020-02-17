//
//  DiscussionViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/17/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class DiscussionViewController: UIViewController {
    let discussionCell = "discussionCell"
    @IBOutlet weak var tblDiscussion: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: "DiscussionCell", bundle: nil)
//        tblDiscussion.register(nib, forCellReuseIdentifier: discussionCell)
        tblDiscussion.register(DiscussionCell.nib, forCellReuseIdentifier: DiscussionCell.identifier)
        tblDiscussion.delegate = self
        tblDiscussion.dataSource = self
        tblDiscussion.rowHeight = UITableView.automaticDimension
        tblDiscussion.estimatedRowHeight = UITableView.automaticDimension
       
    }
}

extension DiscussionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscussionCell.identifier, for: indexPath) as! DiscussionCell
        cell.backgroundColor = .black
        //let cell = Bundle.main.loadNibNamed("DiscussionCell", owner: self, options: nil)?.first as! DiscussionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


