//
//  MypageTableViewCell.swift
//  fiveMovies
//
//  Created by t2023-m0039 on 1/19/24.
//

import UIKit

class MypageTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSeat: UILabel!
    @IBOutlet weak var movieDay: UILabel!
    
    
    
    
    
    func setCell(data: UserData.User.BookedMovie) {
        movieTitle.text = data.title
        movieSeat.text = data.seat
        movieDay.text = data.date
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
