//
//  SelectSeatViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class SelectSeatViewController: UIViewController {

    var selectedPeople: UIButton?
    var selectedSeatIndex: [Int] = []   // 선택된 좌석의 인덱스를 저장하는 배열

    override func viewDidLoad() {
        super.viewDidLoad()

        SeatData.shared.initializeSeats()
        SeatData.shared.load()

        updateSeatUI()
        displayStoredSeats()
    }

    // 인원 수
    @IBAction func selectPeople(_ sender: UIButton) {
        print("selectPeople called for index: \(sender.tag)")
        deselectAllSeats()
        selectedPeople?.isSelected = false      // 전에 선택된 버튼 해제
        sender.isSelected = true                // 현재 눌린 버튼 표시
        selectedPeople = sender                 // 현재 선택된 버튼 갱신

        updateSeatUI()
    }

    // 좌석
    @IBAction func seatTapped(_ sender: UIButton) {
        guard let selectedPeopleTag = selectedPeople?.tag else {
            showAlert(message: "인원 수를 먼저 선택해주세요.")
            return
        }

        let seatIndex = sender.tag
        print("Button tapped with tag: \(seatIndex)")
        let seat = SeatData.Seat.init(isAvailable: true, isSelected: false, seatNum: seatIndex)
        SeatData.shared.seats.append(seat)

        if seat.isAvailable {
            SeatData.shared.seats[seatIndex].isSelected.toggle()    // 선택 가능한 좌석 상태 토글

            // 선택된 자리 인덱스 업데이트
            if  SeatData.shared.seats[seatIndex].isSelected {
                selectedSeatIndex.append(seatIndex) // 현재 좌석이 선택되었을 경우, 배열에 해당 인덱스 추가
            } else {
                if let indexToRemove = selectedSeatIndex.firstIndex(of: seatIndex) {    // 현재 좌석이 해제되었을 경우
                    selectedSeatIndex.remove(at: indexToRemove)                         // 배열에서 해당 인덱스 찾아서 제거
                }
            }

            updateSeatUI()
        } else { // 선택 불가능한 좌석에 대한 처리

        }

        print(#function)
    }

    // 확인
    @IBAction func confirmBtnTap(_ sender: Any) {
        if let selectedPeopleTag = selectedPeople?.tag {
            print("선택된 인원 수: \(selectedPeopleTag)")
            // 선택된 좌석 인덱스를 변환
            let convertSeat = selectedSeatIndex.map { convertSeatNum(forIndex: $0) }
            print("선택된 자리: \(convertSeat)")

            // 선택된 인원 수에 따라 총 금액 계산
            let selectedPeopleCount = selectedPeopleTag
            let seatPrice = 14000
            let totalAmount = selectedPeopleCount * seatPrice


            // MovieBookingVC의 peopleInfo label 업데이트
            if let movieBookingVC = presentingViewController as? MovieBookingViewController {
                movieBookingVC.peopleInfo.text = "\(selectedPeopleTag)"
                movieBookingVC.seatInfo.text = "\(convertSeat.joined(separator: ", "))"
                movieBookingVC.totalAmount = totalAmount
            }
        }
        print("선택된 자리: \(selectedSeatIndex)")

        // 좌석 데이터 저장
        SeatData.shared.save()

        self.dismiss(animated: true)
    }

    func convertSeatNum(forIndex index: Int) -> String {
        let row = ["A", "B", "C", "D"][index / 5]  // 각 행에 5개의 좌석
        let seatNumber = String(format: "%02d", (index % 5) + 1)
        return "\(row)\(seatNumber)"
    }

    // 좌석 업데이트
    func updateSeatUI() {
        for (index, seat) in SeatData.shared.seats.enumerated() {
            let seatBtn = view.viewWithTag(index) as? UIButton        // 좌석 버튼을 태그로부터 가져옴
            seatBtn?.isEnabled = selectedPeople?.isSelected ?? false  // 인원 버튼 상태에 따라 좌석 버튼 활성화
            print("Seat \(index) - isSelected: \(seat.isSelected)")
        }
    }

    // 모든 좌석 선택 해제
    func deselectAllSeats() {
        for (index, _) in SeatData.shared.seats.enumerated() {
            SeatData.shared.seats[index].isSelected = false
        }
        selectedSeatIndex.removeAll()
        updateSeatUI()
        print("deselectAllSeats called")
    }

    func displayStoredSeats() {
        print("저장된 좌석:")
        for (index, seat) in SeatData.shared.seats.enumerated() {
            print("자리 \(index) - 사용 가능: \(seat.isAvailable), 선택됨: \(seat.isSelected)")
        }
    }


    func showAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

