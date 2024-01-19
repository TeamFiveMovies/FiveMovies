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
                UserData.shared.userList[i].bookedList?.append(UserData.User.BookedMovie(title: "영화1", seat: "좌석1", date: "날짜1"))
                UserData.shared.userList[i].bookedList?.append(UserData.User.BookedMovie(title: "영화2", seat: "좌석2", date: "날짜2"))
                UserData.shared.userList[i].bookedList?.append(UserData.User.BookedMovie(title: "영화3", seat: "좌석3", date: "날짜2"))
                return UserData.shared.userList[i].bookedList!
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as? MypageTableViewCell else { return UITableViewCell() }
        
        cell.setCell(data: userBookedListShow()[indexPath.row])
        
        return cell
    }
    
    
}
