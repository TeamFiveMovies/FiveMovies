//
//  MovieDetailViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var detailMovieImage: UIImageView!


    var movieData: MovieData.Movie?

    override func viewDidLoad() {
        super.viewDidLoad()


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
    
}
