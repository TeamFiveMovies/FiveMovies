//
//  data.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import Foundation
import UIKit

class MovieData{
    
    //싱글톤 패턴으로 데이터 구현
    static let shared = MovieData()
    
    private init() {}
    
    public struct Movie {
        let title: String
        let posterPath: String
        let overview: String
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
    
    //이미지 불러오기
//    public func loadMoviePoster(movie:Movie) -> UIImage {
//        
//        if let url = URL(string: "https://image.tmdb.org/t/p/w500" + movie.posterPath) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                guard let data = data, error == nil else { return }
//                DispatchQueue.main.async {
//                    cell.posterImageView.image = UIImage(data: data)
//                }
//            }
//            task.resume()
//        }
//    }
    
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
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                //JSON 데이터 파싱
                var movies = self.parseMovies(json: json)
                self.nowPlayingMovies = movies
                
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        })
        
        dataTask.resume()
    }
    
    //JSON -> [Movie] 파싱
    private func parseMovies(json: [String: Any]) -> [Movie]{
        var movies: [Movie] = []
        
        guard let results = json["results"] as? [[String: Any]] else {
            print("Invalid JSON format")
            return movies
        }
        
        //파싱한 Movie 데이터를 요소로 가지는 새로운 배열 생성
        for movie in results {
            guard let title = movie["title"] as? String, let posterPath = movie["poster_path"] as? String, let overview = movie["overview"] as? String else {
                continue
            }
            
            let movieObject = Movie(title: title, posterPath: posterPath, overview: overview)
            movies.append(movieObject)
        }
        
        return movies
    }
}
