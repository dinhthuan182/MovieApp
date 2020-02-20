//
//  CrewMovieCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/19/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class CrewMovieCell: UITableViewCell {
    
    @IBOutlet weak var cltCrew: UICollectionView!
        
    var filterCrew = [Crew]()
    
    static var identifier: String{
        return String(describing: CrewMovieCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    func setupView() {
        self.cltCrew.register(CrewMovieDetailCell.nib, forCellWithReuseIdentifier: CrewMovieDetailCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        cltCrew.collectionViewLayout = flowLayout
        cltCrew.dataSource = self
        cltCrew.delegate = self
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.cltCrew.frame = CGRect(x: self.cltCrew.frame.minX, y: self.cltCrew.frame.minY, width: self.cltCrew.frame.height, height: CGFloat(self.filterCrew.count / 2 * 55))
            self.cltCrew.reloadData()
        }
    }
}

extension CrewMovieCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterCrew.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewMovieDetailCell.identifier, for: indexPath) as! CrewMovieDetailCell
        let crew = filterCrew[indexPath.row]
        cell.lblTitle.text = crew.name
        cell.lblSubTitle.text = crew.job
        return cell
    }
}

extension CrewMovieCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 50)
    }
}
