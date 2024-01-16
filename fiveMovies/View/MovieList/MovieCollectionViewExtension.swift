//
//  MovieCollectionViewExtension.swift
//  fiveMovies
//
//  Created by t2023-m0044 on 1/16/24.
//

import UIKit

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setCell(displayCollectionView[indexPath.row])
        return cell
    
    }
    
    
    
}
