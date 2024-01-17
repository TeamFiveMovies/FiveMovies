//
//  SelectSeatViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class SelectSeatViewController: UIViewController {

    var seats: [Seat] = []              // 좌석 정보를 담는 Seat 구조체 배열
    var selectedPeople: UIButton?
    var selectedSeatIndex: [Int] = []   // 선택된 좌석의 인덱스를 저장하는 배열

    override func viewDidLoad() {
        super.viewDidLoad()

        // 좌석 배열 초기화
        seats = Array(repeating: Seat(isAvailable: true, isSelected: false), count: 20)

        updateSeatUI()                  // 좌석에 대한 초기 UI 설정
    }

    @IBAction func selectPeople(_ sender: UIButton) {
        deselectAllSeats()
        selectedPeople?.isSelected = false      // 전에 선택된 버튼 해제
        sender.isSelected = true                // 현재 눌린 버튼 표시
        selectedPeople = sender                 // 현재 선택된 버튼 갱신

        updateSeatUI()
    }

    @IBAction func seatTapped(_ sender: UIButton) {
        //        guard selectedPeople?.isSelected == true else {
        //            showAlert(message: "인원 수를 먼저 선택해주세요.")
        //            return
        //        }
        guard let selectedPeopleTag = selectedPeople?.tag else {
            showAlert(message: "인원 수를 먼저 선택해주세요.")
            return
        }

        let seatIndex = sender.tag
        print("Button tapped with tag: \(seatIndex)")
        let selectedSeat = seats[seatIndex]

        if selectedSeat.isAvailable {
            seats[seatIndex].isSelected.toggle()    // 선택 가능한 좌석 상태 토글
            updateSeatUI()
        } else {
            // 선택 불가능한 좌석에 대한 처리
        }

        print(#function)
    }

    @IBAction func confirmBtnTap(_ sender: Any) {
        print("선택된 자리: \(selectedSeatIndex)")

        self.dismiss(animated: true) {
            // let userDefaults = UserDefaults.standard
        }
    }


    func updateSeatUI() {
        for (index, _) in seats.enumerated() {                       // enumerated: 배열의 각 요소와 해당 요소의 인덱스 제공
            let button = view.viewWithTag(index) as? UIButton        // 좌석 버튼을 태그로부터 가져옴

            button?.isEnabled = selectedPeople?.isSelected ?? false  // 인원 버튼 상태에 따라 좌석 버튼 활성화
        }
    }

    // 모든 좌석 선택 해제
    func deselectAllSeats() {
        for (index, _) in seats.enumerated() {
            seats[index].isSelected = false
        }
        selectedSeatIndex.removeAll()
    }

    func showAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


