//
//  ProgramCollectionViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class ProgramCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "programCellId"
    let cellSpacing: CGFloat = 5
    
    var topPrograms = [Program]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(ProgramCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.getListMovie()
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: cellSpacing, bottom: 0, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return topPrograms.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProgramCollectionViewCell
        cell.setupView()
        let program = topPrograms[indexPath.row]
        cell.program = program
    
        return cell
    }
    
    func getListMovie() {
        Api.program.getListProgram(onSuccess: { (topRate) in
            if let topList = topRate.results {
                self.topPrograms = topList
            }
        }) { (error) in
            print("Load program erroe: ", error)
        }
        handleReloadCollection()
    }

    func handleReloadCollection() {
        DispatchQueue.main.async {
            //reload data of message collection
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProgramCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        let height = (UIScreen.main.bounds.size.height - 4 * cellSpacing) / 4
        return CGSize(width: width, height: height)
    }
}
