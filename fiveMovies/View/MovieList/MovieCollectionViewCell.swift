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
        
        if let posterPath = movie?.posterPath {
            loadImage(from: "https://image.tmdb.org/t/p/w500" + posterPath)
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.movieImage.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }
    
}
    

