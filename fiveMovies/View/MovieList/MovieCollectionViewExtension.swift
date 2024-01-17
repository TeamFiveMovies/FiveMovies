//
//  MovieCollectionViewExtension.swift
//  fiveMovies
//
//  Created by t2023-m0044 on 1/16/24.
//

import UIKit

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(displayCollectionView.count)
        return displayCollectionView.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.setCell(displayCollectionView[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let MovieDetailStoryboard = UIStoryboard(name: "MovieDetailStoryboard", bundle: nil)
        
        guard let MovieDetailViewController = MovieDetailStoryboard.instantiateViewController(identifier: "MovieDetail") as? MovieDetailViewController else {
                    return
                }
        MovieDetailViewController.modalPresentationStyle = .automatic
        
        self.present(MovieDetailViewController, animated: true)
    }
    
    
}