//
//  MovieListViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleName: UILabel!
    
    lazy var displayCollectionView = MovieData.shared.nowPlayingMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        MovieData.shared.setData(complitionHandler: { [weak self] in
//            self?.displayCollectionView = MovieData.shared.nowPlayingMovies
//            DispatchQueue.main.async {
//                self?.movieCollectionView.reloadData()
//            }
//        })
        let flowLayout = UICollectionViewFlowLayout()
        movieCollectionView.collectionViewLayout = flowLayout
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
    }
    
    
    @IBAction func selectionValueChanged(_ sender: Any) {
        switch movieSegmentedControl.selectedSegmentIndex {
        case 1:
            displayCollectionView = MovieData.shared.upCommingMovies
            print("Selected segment index: \(String(describing: (sender as AnyObject).selectedSegmentIndex))")
        case 2:
            displayCollectionView = MovieData.shared.popularMovies
            print("Selected segment index: \(String(describing: (sender as AnyObject).selectedSegmentIndex))")
        default:
            displayCollectionView = MovieData.shared.nowPlayingMovies
            print("Selected segment index: \(String(describing: (sender as AnyObject).selectedSegmentIndex))")
        }
        movieCollectionView.reloadData()
    }
    
    @IBAction func movieSearchBtnTap(_ sender: UIButton) {
        
        let MovieSearchStoryboard = UIStoryboard(name: "MovieSearchStoryboard", bundle: nil)
        
        guard let MovieSearchViewController = MovieSearchStoryboard.instantiateViewController(identifier: "MovieSearch") as? MovieSearchViewController else {
            return
        }
        MovieSearchViewController.modalPresentationStyle = .automatic
        
        self.present(MovieSearchViewController, animated: true)
    }
    
    @IBAction func myPageBtnTap(_ sender: UIButton) {
        let MyPageStoryboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
        
        guard let MyPageViewController = MyPageStoryboard.instantiateViewController(identifier: "MyPage") as? MyPageViewController else {
            return
        }
        MyPageViewController.modalPresentationStyle = .automatic
        
        self.present(MyPageViewController, animated: true)
    }
}
