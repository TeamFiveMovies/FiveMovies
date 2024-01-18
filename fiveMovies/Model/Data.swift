//
//  data.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import Foundation

//MARK: 무비 데이터
class MovieData{
    
    //싱글톤 패턴 적용
    static let shared = MovieData()
    private init() {}
    
    //상위 계층
    private struct Result: Codable {
        let results: [Movie]
    }
    
    //하위 계층
    public struct Movie: Codable {
        let title: String
        let overview: String
        let posterPath: String
        
        //맵핑
        private enum CodingKeys: String, CodingKey {
            case title
            case overview
            case posterPath = "poster_path"
        }
    }
    
    //영화 데이터 배열
    public var nowPlayingMovies: [Movie] = []
    public var upCommingMovies: [Movie] = []
    public var popularMovies: [Movie] = []
    public var searchedMovies: [Movie] = []
}

//MARK: 유저 데이터
class UserData {
    
    static let shared = UserData()
    private init () {}
    
    public struct User: Codable {
        var id: String
        var password: String
        var birth: String
        var logIn: Bool
    }
    
    public var userList: [User] = []
    
    //UserDefaults 키
    private let userKey = "user"
    
    public func save() {
        Storage.shared.saveData(key: userKey, data: userList)
    }
    
    public func load() {
        self.userList = Storage.shared.loadData(key: userKey, data: userList)
    }
}

//MARK: 좌석 데이터
public class SeatData {

    public static let shared = SeatData()
    private init () {}

    public struct Seat: Codable {
        var isAvailable: Bool   // 좌석 사용 가능한지
        var isSelected: Bool    // 좌석이 선택되었는지
        var seatNum: Int
    }

    public var seats: [Seat] = []

    //UserDefaults 키
    private let seatKey = "seat"
    
    //UserDefaults 저장, 불러오기 메서드
    
    public func save() {
        Storage.shared.saveData(key: seatKey, data: seats)
    }
    public func load() {
        seats = Storage.shared.loadData(key: seatKey, data: seats)
    }
}

//MARK: API 통신
extension MovieData {
    
    public func getNowPlayingMovies(completion: @escaping () -> Void) {
        
        //파일 형식과 API키를 정의한 헤더부
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2Q1ZTNlYWY2MGViNWY3Njg5YjhjMjIxNTYyMzlhNCIsInN1YiI6IjY1YTUwZDgwMWZiOTRmMDBjMDc0YTFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4pi9VmylhkY94DoJk6s4Ol7txHjXcyonKy3PeI9ZdS8"
        ]
        
        //요청을 보낼 URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1")!
        
        //URL에 요청
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        //HTTP 메서드 설정
        request.httpMethod = "GET"
        
        //요청에 헤더부 추가
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            //에러 처리
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            //데이터 옵셔널 바인딩
            guard let data = data else {
                print("No data received")
                return
            }
            
            //데이터 처리
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Result.self, from: data)
                self.nowPlayingMovies = result.results
                completion()
                print ("현재상영작 데이터 세팅 완료")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        })
        dataTask.resume()
    }
    
    public func getUpCommingMovies(completion: @escaping () -> Void) {
        
        //파일 형식과 API키를 정의한 헤더부
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2Q1ZTNlYWY2MGViNWY3Njg5YjhjMjIxNTYyMzlhNCIsInN1YiI6IjY1YTUwZDgwMWZiOTRmMDBjMDc0YTFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4pi9VmylhkY94DoJk6s4Ol7txHjXcyonKy3PeI9ZdS8"
        ]
        
        //요청을 보낼 URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?language=ko-KR&page=1")!
        
        //URL에 요청
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        //HTTP 메서드 설정
        request.httpMethod = "GET"
        
        //요청에 헤더부 추가
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            //에러 처리
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            //데이터 옵셔널 바인딩
            guard let data = data else {
                print("No data received")
                return
            }
            
            //데이터 처리
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Result.self, from: data)
                self.upCommingMovies = result.results
                completion()
                print ("상영예정작 데이터 세팅 완료")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        })
        dataTask.resume()
    }
    
    public func getPopularMovies(completion: @escaping () -> Void) {
        
        //파일 형식과 API키를 정의한 헤더부
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2Q1ZTNlYWY2MGViNWY3Njg5YjhjMjIxNTYyMzlhNCIsInN1YiI6IjY1YTUwZDgwMWZiOTRmMDBjMDc0YTFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4pi9VmylhkY94DoJk6s4Ol7txHjXcyonKy3PeI9ZdS8"
        ]
        
        //요청을 보낼 URL
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=ko-KR&page=1&sort_by=popularity.desc")!
        
        //URL에 요청
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        //HTTP 메서드 설정
        request.httpMethod = "GET"
        
        //요청에 헤더부 추가
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            //에러 처리
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            //데이터 옵셔널 바인딩
            guard let data = data else {
                print("No data received")
                return
            }
            
            //데이터 처리
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Result.self, from: data)
                self.popularMovies = result.results
                completion()
                print ("인기작 데이터 세팅 완료")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        })
        dataTask.resume()
    }
    
    public func getSearchedMovies(userInput:String, completion: @escaping () -> Void) {
        
        //파일 형식과 API키를 정의한 헤더부
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2Q1ZTNlYWY2MGViNWY3Njg5YjhjMjIxNTYyMzlhNCIsInN1YiI6IjY1YTUwZDgwMWZiOTRmMDBjMDc0YTFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4pi9VmylhkY94DoJk6s4Ol7txHjXcyonKy3PeI9ZdS8"
        ]
        
        //요청을 보낼 URL
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(userInput)&include_adult=false&language=ko-KR&page=1")!
        
        //URL에 요청
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        //HTTP 메서드 설정
        request.httpMethod = "GET"
        
        //요청에 헤더부 추가
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            //에러 처리
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            //데이터 옵셔널 바인딩
            guard let data = data else {
                print("No data received")
                return
            }
            
            //데이터 처리
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Result.self, from: data)
                self.searchedMovies = result.results
                completion()
                print ("검색 영화 세팅 완료")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        })
        dataTask.resume()
    }
}

//MARK: 데이터 관리
//제네릭 타입으로 메서드를 구현하여 여러 데이터 타입을 하나의 메서드로 다룰 수 있도록 구현함
//PropertyWrapper 보다 상대적으로

class Storage {
    
    static let shared = Storage()
    private init() {}
    
    //쓰기 메서드
    public func saveData<T: Codable> (key: String, data: T) {
        do {
            let dataJSON = try JSONEncoder().encode(data)
            UserDefaults.standard.set(dataJSON, forKey: key)
            print("\(key) 세이브 성공")
        }
        catch {
            print( "\(key) 세이브 실패")
        }
    }
    
    //읽기 메서드
    public func loadData<T: Codable> (key: String, data: T) -> T {
        do {
            if let dataJSON = UserDefaults.standard.data(forKey: key) {
                print("\(key) 로드 성공")
                return try JSONDecoder().decode(T.self, from: dataJSON)
            }
        }
        catch {
            print("\(key) 로드 실패")
            return data
        }
        print("\(key) 로드 실패")
        return data
    }
}
