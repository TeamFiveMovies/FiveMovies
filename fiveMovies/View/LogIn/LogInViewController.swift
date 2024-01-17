//
//  ViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var userPasswork: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func logInBtnTap(_ sender: UIButton) {
        let MovieListStoryboard = UIStoryboard(name: "MovieListStoryboard", bundle: nil)
        
        guard let MovieListViewController = MovieListStoryboard.instantiateViewController(identifier: "MovieList") as? MovieListViewController else {
                    return
                }
        MovieListViewController.modalPresentationStyle = .fullScreen
        
        self.present(MovieListViewController, animated: true)
    }
    
    
    
    @IBAction func registerBtnTap(_ sender: UIButton) {
        let RegisterStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        
        guard let RegisterViewController = RegisterStoryboard.instantiateViewController(identifier: "Register") as? RegisterViewController else {
                    return
                }
        RegisterViewController.modalPresentationStyle = .automatic
        
        self.present(RegisterViewController, animated: true)
    }
}

