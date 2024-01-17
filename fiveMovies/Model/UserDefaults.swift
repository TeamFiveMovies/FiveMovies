//
//  API.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import Foundation

//MARK: UserDefaults
class DataStore {
    static let shard = DataStore()
    private init () {}
    
    private let userKey = "user"
    private let seatkey = "seat"
    
    func dataload() {
        //유저 데이터 로드
        do {
            if let userData = UserDefaults.standard.data(forKey: userKey) {
                seats =
            }
            print ("유저 데이터 로드 성공")
        } catch {
            print ("유저 데이터 로드 실패")
        }
    }
    
    func saveUserData() {
        
    }
    
    func saveSeatData() {
        
    }
    
//    func load() {
//        //todoList 로드
//        do {
//            if let TodoData = UserDefaults.standard.data(forKey: toDoKey) {
//                toDoList = try JSONDecoder().decode([Todo].self, from: TodoData)
//                print ("ToDo 로드 성공")
//            }
//        } catch {
//            print ("ToDo 로드 실패")
//        }
//        
//        //categoryList 로드
//        do {
//            if let categoryData = UserDefaults.standard.data(forKey: categoryKey) {
//                categoryList = try JSONDecoder().decode([Category].self, from: categoryData)
//                print ("category 로드 성공")
//            }
//        } catch {
//            print ("category 로드 실패")
//        }
//    }
//    
//    func todoSave() {
//        do {
//            let toDoData = try JSONEncoder().encode(toDoList)
//            UserDefaults.standard.set(toDoData, forKey: toDoKey)
//            print ("ToDo 세이브 성공")
//        } catch {
//            print ("ToDo 세이브 실패")
//        }
//    }
//    
//    func categorySave() {
//        do {
//            let categoryData = try JSONEncoder().encode(categoryList)
//            UserDefaults.standard.set(categoryData, forKey: categoryKey)
//            print ("Category 세이브 성공")
//        } catch {
//            print ("Category 세이브 실패")
//        }
//    }
}


