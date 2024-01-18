//
//  ViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func logInBtnTap(_ sender: UIButton) {
        LoginChecking()
        
        for user in UserData.shared.userList {
            if user.id == userID.text && user.password == userPassword.text {
                let alert = UIAlertController(title: "로그인 하시겠습니까?", message: nil, preferredStyle: .alert)
                let addAction = UIAlertAction(title: "확인", style: .default){_ in
                    self.playUserDataSend(id: user.id, password: user.password)
                    
                    let MovieListStoryboard = UIStoryboard(name: "MovieListStoryboard", bundle: nil)
                    
                    guard let MovieListViewController = MovieListStoryboard.instantiateViewController(identifier: "MovieList") as? MovieListViewController else {
                                return
                            }
                    MovieListViewController.modalPresentationStyle = .fullScreen
                    
                    self.present(MovieListViewController, animated: true)
                }
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(addAction)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
            }
            
        }
        
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

extension LogInViewController {
    func LoginChecking() {
        if userID.text == "" {
            let alert = UIAlertController(title: "아이디를 입력해주세요", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        
        if userPassword.text == "" {
            let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func playUserDataSend(id: String, password: String) {
        playUserID = id
        playUserPassword = password
    }
}
