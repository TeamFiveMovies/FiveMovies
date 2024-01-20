//
//  UserData.swift
//  fiveMovies
//
//  Created by t2023-m0039 on 1/16/24.
//

import Foundation

class UserModel {
    struct UserData: Codable {
        var id: String
        var password: String
        var passwordCheck: String
        var birth: String
    }
    
    var userDataList: [UserData] = []
}



