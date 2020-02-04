//
//  PersonCollectionViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class PersonCollectionViewController: UICollectionViewController {

    private let personCellId = "personCellId"
    
    let cellSpacing: CGFloat = 5
    
    var popularPerson = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView!.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: personCellId)
        getListPerson()
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: cellSpacing, bottom: 0, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return popularPerson.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personCellId, for: indexPath) as! PersonCollectionViewCell
        cell.setupView()
        let person = popularPerson[indexPath.row]
        cell.person = person
    
        return cell
    }

    func getListPerson() {
        Api.person.getListPerson(onSuccess: { (popular) in
            if let popularList = popular.results {
                self.popularPerson = popularList
            }
        }) { (error) in
            print("Load actor error: ", error)
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
extension PersonCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        let height = (UIScreen.main.bounds.size.height - 3 * cellSpacing) / 3
        return CGSize(width: width, height: height)
    }
}
