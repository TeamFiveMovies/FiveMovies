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
    
    var movie: MovieData.Movie?
    
    func setCell(_ _movie: MovieData.Movie) {
        movie = _movie
        
        self.movieName.text = _movie.title
        self.movieName.sizeToFit()
        self.movieImage.contentMode = .scaleAspectFit
        
        if (movie?.posterPath) != nil {
            MovieData.shared.movieToImage(movie: _movie, completion: { [weak self] image in
                DispatchQueue.main.async {
                    self?.movieImage.image = image
                }
            })
        }
    }
}

