//
//  PlayVideoViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/19/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var videoView: YTPlayerView!
    
    // MARK: - properties
    var videoKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let key = videoKey {
            print("key: ", key)
            DispatchQueue.main.async {
                self.videoView.load(withVideoId: key)
            }
        }
    }
    
    @IBAction func closeTrailerClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
