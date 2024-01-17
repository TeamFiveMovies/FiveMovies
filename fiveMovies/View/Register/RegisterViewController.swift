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
    
    var userDataList: [UserData] = []
    let userDataKey = "User"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        userDataList = readUserList()
        print("\(userDataList)")
    }
    
    @IBAction func confirmBtnTap(_ sender: UIButton) {
        
        //UserDefaults에 회원정보 저장
        let newUser = UserData(id: registerID.text!, password: registerPassword.text!, birth: birthDate.date)
        
        
        if dateChecking(userData: newUser) {
            
            let alert = UIAlertController(title: "회원가입 가능합니다", message: "설명", preferredStyle: .alert)
            let addAction = UIAlertAction(title: "가입하기", style: .default){_ in
                
                self.addUserList(userInfo: newUser)
                print("\(self.userDataList)")
                print("\(self.readUserList())")
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
    func addUserList(userInfo: UserData) {
        userDataList.append(userInfo)
        
        print("\(userDataList)")
        
        guard let encodedData = try? JSONEncoder().encode(userInfo) else { return }
        UserDefaults.standard.set(encodedData, forKey: userDataKey)

        
    }
    
    // 전체 유저 정보 조회
    func readUserList() -> [UserData]{
       guard let userListData = UserDefaults.standard.data(forKey: userDataKey),
             let decodedData = try? JSONDecoder().decode([UserData].self, from: userListData)
       else {
           print("왜들어갈까?")
           return [] }
        
        userDataList = decodedData
        
        return decodedData
    }
    

    
    func dateChecking(userData: UserData) -> Bool {
        // 아이디, 비밀번호 빈칸 체크
        if userData.id  == ""{
            
            return false
        }
        if userData.password == "" {
            return false
        }
        
        // 아이디 중복 체크
        for user in userDataList {
            if user.id == userData.id{
                return false
            }
        }
        
        return true
    }
}
