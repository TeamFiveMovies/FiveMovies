//
//  SelectSeatViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class SelectSeatViewController: UIViewController {

    var seats: [Seat] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // 좌석 정보 초기화
        seats = [
            Seat(isAvailable: true, isSelected: false),
            Seat(isAvailable: false, isSelected: false)
        ]

        // 좌석에 대한 초기 UI 설정
        updateSeatUI()
    }

    @IBAction func seatTapped(_ sender: UIButton) {
        let seatIndex = sender.tag
        let selectedSeat = seats[seatIndex]

        if selectedSeat.isAvailable {
            seats[seatIndex].isSelected.toggle()
            updateSeatUI()
        } else {
            // 선택 불가능한 좌석에 대한 처리
        }

        print(#function)
    }

    func updateSeatUI() {
//        for (index, seat) in seats.enumerated() {
//            let button = view.viewWithTag(index) as? UIButton
//
//        }
    }

}
