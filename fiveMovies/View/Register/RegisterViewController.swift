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
    @IBOutlet weak var warnLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserData.shared.load()
        
    }
    
    //MARK: 회원가입 완료 버튼
    @IBAction func confirmBtnTap(_ sender: UIButton) {
        
        let newUser = UserData.User(id: registerID.text!, password: registerPassword.text!, birth: dataFormat(date: birthDate.date)
        , logIn: false)
        
        
        
        if registerChecking(userInfo: newUser){
            let alert = UIAlertController(title: "회원가입 가능합니다", message: nil, preferredStyle: .alert)
            let addAction = UIAlertAction(title: "가입하기", style: .default){_ in
                UserData.shared.userList.append(newUser)
               
                UserData.shared.save()

                self.dismiss(animated: true)
            }

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "회원가입 조건을 지켜주세요", message: nil, preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)

            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
}



extension RegisterViewController {
    
    //MARK: 회원가입 조건
    func registerChecking(userInfo: UserData.User) -> Bool {
        
        if registerID.text == "" || registerPassword.text == ""
            || passwordCheck.text == ""{
            warnLabel.text = "빈칸을 확인해주세요"
            return false
        }
        
        if isValidID(id: userInfo.id) == false{
            registerID.text = ""
            registerID.becomeFirstResponder()
            warnLabel.text = "아이디는 영어,숫자로 12자리 이하로 입력해주세요"
            return false }
        
        if registerPassword.text!.count < 8 {
            registerPassword.text = ""
            passwordCheck.text = ""
            registerPassword.becomeFirstResponder()
            warnLabel.text = "비밀번호를 8자리 이상으로 입력해주세요"
            return false
        }
        
        if registerPassword.text != passwordCheck.text {
            registerPassword.text = ""
            passwordCheck.text = ""
            registerPassword.becomeFirstResponder()
            warnLabel.text = "비밀번호가 일치하지 않습니다."
            return false
        }
        
        for user in UserData.shared.userList {
            
            if user.id == userInfo.id { 
                registerID.text = ""
                registerID.becomeFirstResponder()
                warnLabel.text = "일치한 아이디가 있습니다. 다시 입력하세요"
                return false }
            
        }
        
        warnLabel.text = ""
        
        return true
    }
    
    
    // 정규식으로 영어,숫자만 들어가는지 체크
    func isValidID(id: String) -> Bool {
        let idRegEx = "^[a-zA-Z0-9]{0,12}$"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        return idTest.evaluate(with: id)
    }
    
    // 날짜 데이터 String값으로 바꾸기
    func dataFormat(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
}
