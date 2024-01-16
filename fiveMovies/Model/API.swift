//
//  API.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import Foundation

//MARK: API 통신
//func getNowPlayingMovies() {
//    let headers = [
//        "accept": "application/json",
//        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2Q1ZTNlYWY2MGViNWY3Njg5YjhjMjIxNTYyMzlhNCIsInN1YiI6IjY1YTUwZDgwMWZiOTRmMDBjMDc0YTFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4pi9VmylhkY94DoJk6s4Ol7txHjXcyonKy3PeI9ZdS8"
//    ]
//    
//    let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1")! as URL,
//                                      cachePolicy: .useProtocolCachePolicy,
//                                      timeoutInterval: 10.0)
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//    
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//        
//        //에러 처리
//        if let error = error {
//            print("Error fetching data: \(error)")
//            return
//        }
//        
//        //데이터 옵셔널 바인딩
//        guard let data = data else {
//            print("No data received")
//            return
//        }
//        
//        //데이터 처리
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//            
//            //JSON 데이터 파싱
////            self.parseMovieData(json: json)
//        } catch {
//            print("Error parsing JSON: \(error)")
//        }
//        
//    })
//    
//    dataTask.resume()
//}
//
////MARK: JSON 파싱
//func parseNowPlayingMovies(json: [String: Any]) {
//    guard let results = json["results"] as? [[String: Any]] else {
//        print("Invalid JSON format")
//        return
//    }
//    
//    //파싱하여 데이터 배열에 추가
//    for movie in results {
//        guard let title = movie["title"] as? String, let posterPath = movie["poster_path"] as? String else {
//            continue
//        }
//        
//        let movieObject = Movie(title: title, posterPath: posterPath)
//        nowPlayingMovies.append(movieObject)
//    }
//}
