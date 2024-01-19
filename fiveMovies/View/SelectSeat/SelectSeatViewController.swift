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

        handleSeat(at: seatIndex)
        //print(#function)
    }

    // 확인
    @IBAction func confirmBtnTap(_ sender: Any) {
        handleConfirmBtn()
    }

    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // 좌석 선택 및 해제 로직
    private func handleSeat(at index: Int) {
        let seat = SeatData.Seat(isAvailable: true, isSelected: false, seatNum: index)
        // 좌석 데이터에 새로운 좌석 추가
        SeatData.shared.seats.append(seat)

        if seat.isAvailable {
            SeatData.shared.seats[index].isSelected.toggle()
            updateSelectedSeat(at: index)
            updateSeatUI()
        } else {
            // 선택 불가능한 좌석에 대한 처리
        }
    }

    // 선택된 좌석 인덱스 업데이트
    private func updateSelectedSeat(at index: Int) {
        if SeatData.shared.seats[index].isSelected {
            // 선택된 좌석의 인덱스를 배열에 추가
            selectedSeatIndex.append(index)
        } else {
            // 배열에서 해당 인덱스를 찾아서 제거
            if let indexToRemove = selectedSeatIndex.firstIndex(of: index) {
                selectedSeatIndex.remove(at: indexToRemove)
            }
        }
    }

    // 확인 버튼
    private func handleConfirmBtn() {
        guard let selectedPeopleTag = selectedPeople?.tag else {
            showAlert(message: "인원 수를 먼저 선택해주세요.")
            return
        }
        // 선택된 좌석 인덱스를 변환
        let convertSeat = selectedSeatIndex.map { convertSeatNum(forIndex: $0) }
        print("선택된 자리: \(convertSeat)")

        // 선택된 인원 수에 따라 총 금액 계산
        let selectedPeopleCount = selectedPeopleTag
        let seatPrice = 14000
        let totalAmount = selectedPeopleCount * seatPrice

        if let movieBookingVC = presentingViewController as? MovieBookingViewController {
            movieBookingVC.peopleInfo.text = "\(selectedPeopleTag)"
            movieBookingVC.seatInfo.text = "\(convertSeat.joined(separator: ", "))"
            movieBookingVC.totalAmount = totalAmount
        }

        SeatData.shared.save()

        self.dismiss(animated: true)
    }

    // 좌석번호 변환
    func convertSeatNum(forIndex index: Int) -> String {
        let row = ["A", "B", "C", "D"][index / 5]  // 각 행에 5개의 좌석
        let seatNumber = String(format: "%02d", (index % 5) + 1)
        return "\(row)\(seatNumber)"
    }

    // 좌석 업데이트
    func updateSeatUI() {
        for (index, seat) in SeatData.shared.seats.enumerated() {
            let seatBtn = view.viewWithTag(index) as? UIButton
            // 인원 버튼 상태에 따라 좌석 버튼 활성화
            seatBtn?.isEnabled = selectedPeople?.isSelected ?? false
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

