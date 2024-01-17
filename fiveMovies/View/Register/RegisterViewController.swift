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
    
    var userModel = UserModel()
    
    
    
    let userDataKey = "User"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(readUserList())")
    }
    
    @IBAction func confirmBtnTap(_ sender: UIButton) {
        var userData = userModel.userDataList
        
        //UserDefaults에 회원정보 저장
        let newUser = UserModel.UserData(id: registerID.text!, password: registerPassword.text!, passwordCheck: passwordCheck.text!, birth: dataFormat(date: birthDate.date))
        
        
        if registerChecking(userData: newUser){
            let alert = UIAlertController(title: "회원가입 가능합니다", message: "설명", preferredStyle: .alert)
            let addAction = UIAlertAction(title: "가입하기", style: .default){_ in
                userData.append(newUser)
                print("\(userData)")
                self.addUserList(userInfo: userData)

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
    // 유저 정보 추가
    func addUserList(userInfo: [UserModel.UserData]) {
        guard let encodedData = try? JSONEncoder().encode(userInfo) else { return }
        UserDefaults.standard.set(encodedData, forKey: userDataKey)
    }
    
    // 전체 유저 정보 조회
    func readUserList() -> [UserModel.UserData]{
       guard let userListData = UserDefaults.standard.data(forKey: userDataKey),
             let decodedData = try? JSONDecoder().decode([UserModel.UserData].self, from: userListData)
       else {
           return [] }
        
        return decodedData
    }
    
    func registerChecking(userData: UserModel.UserData) -> Bool {
        if userData.id == "" || userData.password == ""
            || userData.password != userData.passwordCheck{
            return false
        }
        
        for i in readUserList() {
            if i.id == userData.id {
                print("\(i)")
                return false
            }
        }
        return true
    }
    
    func dataFormat(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
}
