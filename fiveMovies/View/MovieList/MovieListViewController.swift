//
//  MovieListViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func movieSearchBtnTap(_ sender: UIButton) {
        
        let MovieSearchStoryboard = UIStoryboard(name: "MovieSearchStoryboard", bundle: nil)
        
        guard let MovieSearchViewController = MovieSearchStoryboard.instantiateViewController(identifier: "MovieSearch") as? MovieSearchViewController else {
                    return
                }
        MovieSearchViewController.modalPresentationStyle = .automatic
        
        self.present(MovieSearchViewController, animated: true)
    }
    
    @IBAction func myPageBtnTap(_ sender: UIButton) {
        let MyPageStoryboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
        
        guard let MyPageViewController = MyPageStoryboard.instantiateViewController(identifier: "MyPage") as? MyPageViewController else {
                    return
                }
        MyPageViewController.modalPresentationStyle = .automatic
        
        self.present(MyPageViewController, animated: true)
    }
    
    @IBAction func moviesTap(_ sender: UIButton) {
        
        let MovieDetailStoryboard = UIStoryboard(name: "MovieDetailStoryboard", bundle: nil)
        
        guard let MovieDetailViewController = MovieDetailStoryboard.instantiateViewController(identifier: "MovieDetail") as? MovieDetailViewController else {
                    return
                }
        MovieDetailViewController.modalPresentationStyle = .automatic
        
        self.present(MovieDetailViewController, animated: true)
    }
    
}
