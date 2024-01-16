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
        
        var userList:[UserData] = []
        let userDataKey = "User"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
        
        //UserDefaults에 회원정보 저장
        
        let alert = UIAlertController(title: "회원가입 가능합니다", message: "설명", preferredStyle: .alert)
                let addAction = UIAlertAction(title: "가입하기", style: .default){_ in
                    let newUser = UserData(id: self.registerID.text!, password: self.registerPassword.text!, birth: self.birthDate.date)
                    
                    self.dateChecking(userDate: newUser)
                    self.addUserList(userDate: newUser)
                    self.dismiss(animated: true)
                }

                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(addAction)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
    }
    
}


extension RegisterViewController {
    func dateChecking(userDate: UserData) {
        // 아이디, 비밀번호 빈칸 체크
        if userDate.id  == ""{
            let alert = UIAlertController(title: "아이디를 입력해주세요", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        if userDate.password == ""{
            let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        
        // 아이디 중복 체크
        for i in readUserList() {
            if i.id == userDate.id{
                let alert = UIAlertController(title: "중복된 아이디가 있습니다. 다시 입력해주세요.", message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    // 유저 정보 추가
    func addUserList(userDate: UserData) {
        userList.append(userDate)
        
        guard let encodedData = try? JSONEncoder().encode(userDate) else { return }
        UserDefaults.standard.set(encodedData, forKey: userDataKey)
    }
    
    // 전체 유저 정보 조회
    func readUserList() -> [UserData]{
        guard let userListData = UserDefaults.standard.data(forKey: userDataKey),
              let decodedData = try? JSONDecoder().decode([UserData].self, from: userListData) else { return [] }
        
        userList = decodedData
        
        return decodedData
    }
    
    // 특정 유저 정보 조회
    func inquiryUserList(id: String) {
        
        
    }
}
