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
    @IBOutlet weak var myPageCollectionView: UICollectionView!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    var testArray: [UserData.User.BookedMovie] = [UserData.User.BookedMovie(title: "영화이름영화이름영화이름영화이름영화이름", seat: "좌석", date: "날짜")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userShow()
        
        myPageCollectionView.delegate = self
        myPageCollectionView.dataSource = self
        
    }
    
    
    @IBAction func userSignOutButton(_ sender: Any) {
        UserSigOut()

        var presentingViewController = self.presentingViewController
        while presentingViewController != nil {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        presentingViewController = presentingViewController?.presentingViewController
        }
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
        for i in 0 ..< UserData.shared.userList.count {
            if UserData.shared.userList[i].logIn {
                userID.text = UserData.shared.userList[i].id
                userPassword.text = UserData.shared.userList[i].password
                userBirth.text = UserData.shared.userList[i].birth
            }
        }
    }

    // 로그인한 유저 영화 예매 정보 가져오기
    func userBookedListShow() -> [UserData.User.BookedMovie]{
        
        for i in 0 ..< UserData.shared.userList.count {
            if UserData.shared.userList[i].logIn {
                return UserData.shared.userList[i].bookedList ?? testArray
            }
        }
        return []
    }
    
}


extension MyPageViewController: UICollectionViewDelegate{
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userBookedListShow().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  myPageCollectionView .dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! MyPageCollectionViewCell
        
        
        cell.dataSet(data: userBookedListShow()[indexPath.row])
        
        return cell
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: myPageCollectionView.frame.size.width  , height:  myPageCollectionView.frame.height)
        }
}
