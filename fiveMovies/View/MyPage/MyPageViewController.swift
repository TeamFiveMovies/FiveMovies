//
//  MyPageViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userPassword: UILabel!
    @IBOutlet weak var userBirth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userShow()
    }
    
    
    @IBAction func userSignOutButton(_ sender: Any) {
        UserSigOut()

        let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let MainViewController = MainStoryboard.instantiateViewController(identifier: "LogIn") as? LogInViewController else {
                    return
                }
        
        MainViewController.modalPresentationStyle = .fullScreen
        
        self.present(MainViewController, animated: true)
    }
    
    
    
    func UserSigOut() {
        for i in 0 ..< UserData.shared.userList.count {
            if UserData.shared.userList[i].logIn == true{
                UserData.shared.userList[i].logIn = false
            }
        }
    }
    
    func userShow() {
        for user in  UserData.shared.userList {
            if user.logIn == true{
                userID.text = user.id
                userPassword.text = user.password
                userBirth.text = user.birth
            }
        }
    }

    func userReservationDetailsShow() {
        
    }
}
