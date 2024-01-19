//
//  SearchCell.swift
//  fiveMovies
//
//  Created by t2023-m0044 on 1/17/24.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    
    var searchMovie: MovieData.Movie?
    
    func setCell(_ _movie: MovieData.Movie) {
        searchMovie = _movie
        
        print("Title: \(_movie.title)")
        print("Poster Path: \(_movie.posterPath)")
        
        self.searchTitle.text = _movie.title
        self.searchTitle.sizeToFit()
        self.searchImage.contentMode = .scaleAspectFit
        
        if (searchMovie?.posterPath) != nil {
            MovieData.shared.movieToImage(movie: _movie, completion: { [weak self] image in
                DispatchQueue.main.async {
                    self?.searchImage.image = image
                }
            })
        }
    }
}
