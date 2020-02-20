//
//  CastMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

protocol CastDelegate {
    func showPersonDetail(person: Person)
}

class CastMovieDetailCell: UITableViewCell {
    
    static var identifier: String{
        return String(describing: CastMovieDetailCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }

    var cast = [Cast]()
    
    var delegate: CastDelegate?
    @IBOutlet weak var cltCasts: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionViewSetup() {
        self.cltCasts.register(CastInMovieDetailCell.nib, forCellWithReuseIdentifier: CastInMovieDetailCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        cltCasts.collectionViewLayout = flowLayout
        cltCasts.dataSource = self
        cltCasts.delegate = self
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            self.cltCasts.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CastMovieDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastInMovieDetailCell.identifier, for: indexPath) as! CastInMovieDetailCell
        let c = cast[indexPath.row]
        if let profile =  c.profilePath {
            cell.imgProfile.loadImageUsingCacheWithUrlString(imgName:profile)
        }
        
        cell.lblName.text = c.name
        cell.lblSubTitle.text = c.character
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let c = cast[indexPath.row]
        Api.person.getPersonDetail(with: c.id, onSuccess: { (person) in
            self.delegate?.showPersonDetail(person: person)
        }) { (error) in
            print("Load person detail error: ", error)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CastMovieDetailCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.height)
    }
}
