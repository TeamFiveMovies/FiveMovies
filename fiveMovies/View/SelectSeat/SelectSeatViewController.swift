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
        seats = Array(repeating: Seat(isAvailable: true, isSelected: false), count: 20)

        updateSeatUI()                  // 좌석에 대한 초기 UI 설정
    }

    @IBAction func selectPeople(_ sender: UIButton) {
        selectedPeople?.isSelected = false      // 전에 선택된 버튼 해제
        sender.isSelected = true                // 현재 눌린 버튼 표시
        selectedPeople = sender                 // 현재 선택된 버튼 갱신

        updateSeatUI()
    }

    @IBAction func seatTapped(_ sender: UIButton) {
        guard selectedPeople?.isSelected == true else {
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
        self.dismiss(animated: true) {
            // let userDefaults = UserDefaults.standard
        }
    }



    
    func updateSeatUI() {
        for (index, seat) in seats.enumerated() {
            let button = view.viewWithTag(index) as? UIButton   // 좌석 버튼을 태그로부터 가져옴

            button?.isEnabled = selectedPeople?.isSelected ?? false  // 현재 선택된 인원 버튼 상태에 따라 좌석 버튼 활성화 여부 설정
        }
    }

    func showAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


