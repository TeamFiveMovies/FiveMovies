//
//  data.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import Foundation
import UIKit

class MovieData{
    
    //싱글톤 패턴 적용
    static let shared = MovieData()
    private init() {}
    
    //상위 계층
    public struct Result: Codable {
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
    
    public func setData() {
        getNowPlayingMovies()
//        getUpCommingMovies()
//        getPopularMovies()
    }
}

extension MovieData {
    
    private func getNowPlayingMovies () {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmM2Q1ZTNlYWY2MGViNWY3Njg5YjhjMjIxNTYyMzlhNCIsInN1YiI6IjY1YTUwZDgwMWZiOTRmMDBjMDc0YTFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4pi9VmylhkY94DoJk6s4Ol7txHjXcyonKy3PeI9ZdS8"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
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
                print ("현재상영작 데이터 세팅 완료")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        })
        dataTask.resume()
    }
}
