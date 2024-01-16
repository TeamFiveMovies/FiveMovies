//
//  MovieDetailViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
