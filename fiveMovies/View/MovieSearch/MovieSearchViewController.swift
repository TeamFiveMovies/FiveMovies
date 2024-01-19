//
//  MovieSearchViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieSearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    lazy var filteredMovies: [MovieData.Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieData.shared.getSearchedMovies(userInput: "", completion: { [weak self] in
            self?.filteredMovies = MovieData.shared.searchedMovies
            DispatchQueue.main.async {
                self?.searchCollectionView.reloadData()
            }
        })
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 8
        searchCollectionView.collectionViewLayout = flowLayout
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Enter Movie Title"
        searchBar.delegate = self
    }
    
    
    @IBAction func backToList(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //타이핑 시, 문자열을 getSearchedMovies로 키워드를 받는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MovieData.shared.getSearchedMovies(userInput: searchText, completion: { [weak self] in
            self?.filteredMovies = MovieData.shared.searchedMovies
            DispatchQueue.main.async {
                self?.searchCollectionView.reloadData()
            }
        })
    }
    //엔터를 누르면 키보드가 내려가는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(filteredMovies.count)
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
        searchCell.setCell(filteredMovies[indexPath.row])

        
        return searchCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //선택된 cell에 해당되는 데이터 가져오기
        let selectedMovie = filteredMovies[indexPath.row]
        
        let MovieDetailStoryboard = UIStoryboard(name: "MovieDetailStoryboard", bundle: nil)
        
        guard let MovieDetailViewController = MovieDetailStoryboard.instantiateViewController(identifier: "MovieDetail") as? MovieDetailViewController else {
                    return
                }
        //MovieDetailViewController의 movieData 프로퍼티에 인스턴스
        MovieDetailViewController.movieData = selectedMovie
        
        MovieDetailViewController.modalPresentationStyle = .automatic
        
        self.present(MovieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 24) / 2
        let cellHeight = cellWidth * 1.7
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
