//
//  UserData.swift
//  fiveMovies
//
//  Created by t2023-m0039 on 1/16/24.
//

import Foundation


class UserData {
    struct UserDatas: Codable {
        var id: String
        var password: String
        var birth: Date
    }
    
    var userDataList: [UserDatas] = []
    let userDataKey = "User"
    
    
    func dateChecking(userData: UserDatas) -> Bool {
        // 아이디, 비밀번호 빈칸 체크
        if userData.id  == ""{
            
            return false
        }
        if userData.password == "" {
            return false
        }
        
        // 아이디 중복 체크
        for user in readUserList() {
            if user.id == userData.id{
                return false
            }
        }
        
        return true
        
    }
    
    // 유저 정보 추가
    func addUserList(userData: UserDatas) {
        userDataList = readUserList()
        userDataList.append(userData)
        
        guard let encodedData = try? JSONEncoder().encode(userData) else { return }
        UserDefaults.standard.set(encodedData, forKey: userDataKey)
        print("\(encodedData) 추가")
        print("\(userDataList)")
        print("\(readUserList())")
        
    }
    
    // 전체 유저 정보 조회
    func readUserList() -> [UserDatas]{
        guard let userListData = UserDefaults.standard.data(forKey: userDataKey),
              let decodedData = try? JSONDecoder().decode([UserDatas].self, from: userListData) else { return [] }
        
        userDataList = decodedData
        
        return decodedData
    }
}

