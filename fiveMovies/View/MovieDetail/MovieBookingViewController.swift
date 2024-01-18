//
//  MovieBookingViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieBookingViewController: UIViewController {

    @IBOutlet weak var peopleInfo: UILabel!
    @IBOutlet weak var seatInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func checkOutBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
        
        //UserDefaults에 예매정보 저장
    }
    
    
    @IBAction func selectSeatBtnTap(_ sender: UIButton) {
        let SelectSeatStoryboard = UIStoryboard(name: "SelectSeatStoryboard", bundle: nil)
        
        guard let SelectSeatViewController = SelectSeatStoryboard.instantiateViewController(identifier: "SelectSeat") as? SelectSeatViewController else {
                    return
                }
        SelectSeatViewController.modalPresentationStyle = .automatic
        
        self.present(SelectSeatViewController, animated: true)
    }
    
    @IBAction func cancelBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
