//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movie: Movie?
    
    let imgBackdrop: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ironman_backrop")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgPoster: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ironman_backrop")
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Iron Man"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblGenres: UILabel = {
        let lbl = UILabel()
        lbl.text = "Actor"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblRated: UILabel = {
        let lbl = UILabel()
        lbl.text = "★★★☆☆"
        lbl.textColor = .orange
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customRGB(222, 222, 222, 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblOverView: UILabel = {
        let lbl = UILabel()
        lbl.text = "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga."
        var height = lbl.optimalHeight
        lbl.frame = CGRect(x: lbl.frame.origin.x, y: lbl.frame.origin.y, width: lbl.frame.width, height: height)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
//    let cltActor: UICollectionView = {
//        let collection = UICollectionView()
//        collection.backgroundColor = .cyan
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        return collection
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        view.addSubview(imgBackdrop)
        view.addSubview(vContent)
        
        vContent.addSubview(imgPoster)
        vContent.addSubview(lblTitle)
        vContent.addSubview(lblGenres)
        vContent.addSubview(lblRated)
        vContent.addSubview(separatorLine)
        vContent.addSubview(lblOverView)
        
        NSLayoutConstraint.activate([
            imgBackdrop.topAnchor.constraint(equalTo: view.topAnchor),
            imgBackdrop.leftAnchor.constraint(equalTo: view.leftAnchor),
            imgBackdrop.widthAnchor.constraint(equalTo: view.widthAnchor),
            imgBackdrop.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            vContent.topAnchor.constraint(equalTo: imgBackdrop.bottomAnchor, constant: 10),
            vContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            vContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            vContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            imgPoster.topAnchor.constraint(equalTo: vContent.topAnchor),
            imgPoster.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            imgPoster.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.35),
            imgPoster.heightAnchor.constraint(equalTo: vContent.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: vContent.topAnchor),
            lblTitle.leftAnchor.constraint(equalTo: imgPoster.rightAnchor, constant: 8),
            lblTitle.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            lblGenres.topAnchor.constraint(equalTo: lblTitle.bottomAnchor),
            lblGenres.leftAnchor.constraint(equalTo: imgPoster.rightAnchor, constant: 8),
            lblGenres.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            lblRated.topAnchor.constraint(equalTo: lblGenres.bottomAnchor),
            lblRated.leftAnchor.constraint(equalTo: imgPoster.rightAnchor, constant: 8),
            lblRated.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: imgPoster.bottomAnchor, constant: 15),
            separatorLine.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            separatorLine.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            lblOverView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 10),
            lblOverView.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            lblOverView.widthAnchor.constraint(equalTo: vContent.widthAnchor)
        ])
    }
}
