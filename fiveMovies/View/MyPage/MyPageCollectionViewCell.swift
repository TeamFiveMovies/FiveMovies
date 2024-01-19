//
//  MyPageCollectionViewCell.swift
//  fiveMovies
//
//  Created by t2023-m0039 on 1/19/24.
//

import UIKit

class MyPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSeat: UILabel!
    @IBOutlet weak var movieDay: UILabel!
    
    
    func dataSet(data: UserData.User.BookedMovie) {
        movieTitle.text = data.title
        movieSeat.text = data.seat
        movieDay.text = data.date
    }
}
