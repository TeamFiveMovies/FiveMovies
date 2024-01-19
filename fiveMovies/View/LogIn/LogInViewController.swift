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
    @IBOutlet weak var warnLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserData.shared.load()
        userLoginReset()
        userID.becomeFirstResponder()
        print("\(UserData.shared.userList)")
    }

    @IBAction func logInBtnTap(_ sender: UIButton) {
            
        if BlankChecking() {
            let alert = UIAlertController(title: "로그인 하시겠습니까?", message: nil, preferredStyle: .alert)
            let addAction = UIAlertAction(title: "확인", style: .default){_ in
                    
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
    
    
    
    @IBAction func registerBtnTap(_ sender: UIButton) {
        let RegisterStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        
        guard let RegisterViewController = RegisterStoryboard.instantiateViewController(identifier: "Register") as? RegisterViewController else {
                    return
                }
        RegisterViewController.modalPresentationStyle = .automatic
        
        self.present(RegisterViewController, animated: true)
    }
    
    func userLoginReset() {
        for i in 0 ..< UserData.shared.userList.count {
            UserData.shared.userList[i].logIn = false
        }
    }
    
}

extension LogInViewController {
    func BlankChecking() -> Bool {
        if userID.text == "" {
            userID.becomeFirstResponder()
            warnLabel.text = "아이디를 입력해주세요."
            return false
        }
        
        if userPassword.text == "" {
            userPassword.text = ""
            userPassword.becomeFirstResponder()
            warnLabel.text = "비밀번호를 입력해주세요."
            return false
        }
        
        for i in 0 ..< UserData.shared.userList.count {
            if UserData.shared.userList[i].id == userID.text && UserData.shared.userList[i].password == userPassword.text{
                
                UserData.shared.userList[i].logIn = true
                
                
                return true
            }
            
        }
        
        userID.text = ""
        userPassword.text = ""
        userID.becomeFirstResponder()
        warnLabel.text = "등록되지 않은 계정입니다."
        
        return false
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userID {
            self.userPassword.becomeFirstResponder()
        } else if textField == self.userPassword {
            
        }
        return true
    }
}
