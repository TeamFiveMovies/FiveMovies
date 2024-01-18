//
//  MyPageViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userBirth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func userSignOutButton(_ sender: Any) {

        let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let MainViewController = MainStoryboard.instantiateViewController(identifier: "LogIn") as? LogInViewController else {
                    return
                }
        
        MainViewController.modalPresentationStyle = .fullScreen
        
        self.present(MainViewController, animated: true)
    }
    
    
    
    
    

}
