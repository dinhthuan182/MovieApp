//
//  SeriesCollectionViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class SeriesCollectionViewController: UICollectionViewController {
    private let SeriesCellId = "seriesCellId"
    
    let cellSpacing: CGFloat = 5
    
    var topSeries = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: SeriesCellId)

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCellId, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

}
