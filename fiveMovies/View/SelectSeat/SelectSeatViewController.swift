//
//  SelectSeatViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class SelectSeatViewController: UIViewController {

    var seats: [Seat] = []              // 좌석 정보를 담는 Seat 구조체 배열
    var selectedPeople: UIButton?       // 현재 선택된 인원 버튼을 추적하기 위한 변수

    override func viewDidLoad() {
        super.viewDidLoad()

        // 좌석 정보 초기화
        seats = [
            Seat(isAvailable: true, isSelected: false),
            Seat(isAvailable: false, isSelected: false),
        ]

        // 좌석에 대한 초기 UI 설정
        updateSeatUI()
    }

    @IBAction func selectPeople(_ sender: UIButton) {
        selectedPeople?.isSelected = false      // 전에 선택된 버튼 해제
        sender.isSelected = true                // 현재 눌린 버튼 표시
        selectedPeople = sender                 // 현재 선택된 버튼 갱신

        updateSeatUI()
    }

    @IBAction func seatTapped(_ sender: UIButton) {
        let seatIndex = sender.tag
        let selectedSeat = seats[seatIndex]

        if selectedSeat.isAvailable {
            seats[seatIndex].isSelected.toggle()    // 선택 가능한 좌석 상태 토글
            updateSeatUI()
        } else {
            // 선택 불가능한 좌석에 대한 처리
        }

        print(#function)
    }

    func updateSeatUI() {
        for (index, seat) in seats.enumerated() {
            let button = view.viewWithTag(index) as? UIButton   // 좌석 버튼을 태그로부터 가져옴

            button?.isEnabled = selectedPeople?.isSelected ?? false  // 현재 선택된 인원 버튼 상태에 따라 좌석 버튼 활성화 여부 설정
        }
    }

}
