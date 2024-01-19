//
//  MovieDetailViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailMovieImage: UIImageView!
    @IBOutlet weak var detailDescript: UITextView!
    
    var movieData: MovieData.Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieData = movieData {
            callMovieData(movieData)
        }
    }

    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func bookingBtnTap(_ sender: UIButton) {
        let MovieBookingStoryboard = UIStoryboard(name: "MovieBookingStoryboard", bundle: nil)
        
        guard let MovieBookingViewController = MovieBookingStoryboard.instantiateViewController(identifier: "MovieBooking") as? MovieBookingViewController else {
                    return
                }
        MovieBookingViewController.modalPresentationStyle = .fullScreen
        
        self.present(MovieBookingViewController, animated: true)
    }


    func callMovieData(_ _movie: MovieData.Movie) {
        movieData = _movie

        self.detailName.text = _movie.title
        self.detailName.sizeToFit()
        self.detailMovieImage.contentMode = .scaleToFill
        self.detailDescript.text = _movie.overview

        if let posterPath = movieData?.posterPath {
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
                self?.detailMovieImage.image = UIImage(data: data)
            }
        }

        task.resume()
    }

}
