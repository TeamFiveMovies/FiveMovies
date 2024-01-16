//
//  MovieCollectionViewCell.swift
//  fiveMovies
//
//  Created by t2023-m0044 on 1/16/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var movie: Movie?
    
    func setCell(_ _movie: Movie) {
        movie = _movie
        
        self.movieName.text = _movie.name
        self.movieName.sizeToFit()
        self.movieImage.image = UIImage(named: _movie.image)
        
    }
    
}
