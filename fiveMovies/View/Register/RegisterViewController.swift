//
//  RegisterViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerID: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var passwordCheck: UITextField!
    @IBOutlet weak var birthDate: UIDatePicker!
    
    var userData = UserData()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirmBtnTap(_ sender: UIButton) {
        
        //UserDefaults에 회원정보 저장
        let newUser = UserData.UserDatas(id: registerID.text!, password: registerPassword.text!, birth: birthDate.date)
        
        
        if userData.dateChecking(userData: newUser) {
            
            let alert = UIAlertController(title: "회원가입 가능합니다", message: "설명", preferredStyle: .alert)
            let addAction = UIAlertAction(title: "가입하기", style: .default){_ in
                
                self.userData.addUserList(userData: newUser)
                self.dismiss(animated: true)
            }

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
        }else {
            let alert = UIAlertController(title: "회원가입 형식을 지켜주세요", message: "설명", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)

            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
}

extension RegisterViewController {
    
}
