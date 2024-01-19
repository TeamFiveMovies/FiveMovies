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
    @IBOutlet weak var myPageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userShow()
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
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
    
    
    // logIn값 false으로 만들기
    func UserSigOut() {
        for i in 0 ..< UserData.shared.userList.count {
            if UserData.shared.userList[i].logIn{
                UserData.shared.userList[i].logIn = false
                print("\(UserData.shared.userList[i]) 로그아웃")
            }
        }
    }
    
    // 유저 정보 띄우기
    func userShow() {
        for user in  UserData.shared.userList {
            if user.logIn{
                userID.text = user.id
                userPassword.text = user.password
                userBirth.text = user.birth
                print("\(user)")
            }
        }
    }

    // 로그인한 유저 영화 예매 정보 받기
    func userBookedListShow() -> [UserData.User.BookedMovie]{
        for i in 0 ..<  UserData.shared.userList.count {
            if UserData.shared.userList[i].logIn{
                
                print("\(String(describing: UserData.shared.userList[i].bookedList))")
                
                return UserData.shared.userList[i].bookedList ?? []
            }
        }
        return []
    }
    
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBookedListShow().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as? MypageTableViewCell
        
        print("\(userBookedListShow()[indexPath.row])")
        cell!.setCell(data: userBookedListShow()[indexPath.row])
        
        return cell!
    }
    
    
}
