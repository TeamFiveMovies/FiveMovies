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
        self.searchImage.contentMode = .scaleToFill
        
        if let posterPath = searchMovie?.posterPath {
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
                self?.searchImage.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }
}
