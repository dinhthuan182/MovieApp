//
//  InfoMovieDetailCell.swift
//  MovieApplication
//
//  Created by Catalina on 2/13/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class InfoMovieDetailCell: UITableViewCell, UITextViewDelegate {

    static var identifier: String{
        return String(describing: InfoMovieDetailCell.self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    var filterCrew = [Crew]()
    var crews =  [Crew]() {
        didSet {
            for crew in crews {
                var flag = false
                for item in filterCrew {
                    if crew.job == item.job {
                        flag = true
                    }
                }
                
                if !flag {
                    filterCrew.append(crew)
                }
                
                if filterCrew.count >= 10 {
                    self.handleReloadData()
                    break
                }
            }
        }
    }
    
    @IBOutlet weak var tvOverview: UITextView!
    @IBOutlet weak var tvOverViewHC: NSLayoutConstraint!
    @IBOutlet weak var cltCrew: UICollectionView!
    @IBOutlet weak var cltCrewHC: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView() {
        tvOverview.delegate = self
        textViewDidChange(tvOverview)
        self.cltCrew.register(CrewMovieDetailCell.nib, forCellWithReuseIdentifier: CrewMovieDetailCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        cltCrew.collectionViewLayout = flowLayout
        cltCrew.dataSource = self
        cltCrew.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let sizeToFitIn = CGSize(width: textView.bounds.size.width, height: CGFloat(MAXFLOAT))
        let newSize = textView.sizeThatFits(sizeToFitIn)
        self.tvOverViewHC.constant = newSize.height
    }
    
    func handleReloadData() {
        DispatchQueue.main.async {
            let numCell = self.filterCrew.count
            self.cltCrew.translatesAutoresizingMaskIntoConstraints = false
            print(numCell / 2)
            if numCell % 2 == 0 {
                self.cltCrew.heightAnchor.constraint(equalToConstant: CGFloat(numCell / 2 * 55)).isActive = true
            } else {
                self.cltCrew.heightAnchor.constraint(equalToConstant: CGFloat(numCell / 2 * 55 + 55)).isActive = true
            }
            
            self.cltCrew.reloadData()
        }
    }
}

extension InfoMovieDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension InfoMovieDetailCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 50)
    }
}
