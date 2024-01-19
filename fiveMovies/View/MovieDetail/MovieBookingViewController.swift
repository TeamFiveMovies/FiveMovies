//
//  MovieBookingViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieBookingViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var peopleInfo: UILabel!
    @IBOutlet weak var seatInfo: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    var selectedMovieTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        SeatData.shared.load()

        movieName.text = selectedMovieTitle
        setupDatePicker()
    }

    @IBAction func checkOutBtnTap(_ sender: UIButton) {
        paymentAlert()
    }


    @IBAction func selectSeatBtnTap(_ sender: UIButton) {
        selectSeat()
    }

    @IBAction func cancelBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    // 날짜
    func setupDatePicker() {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 1
        dateComponents.day = 22
        dateComponents.hour = 6             // 24/1/22  오전 6:00

        guard let minDate = calendar.date(from: dateComponents) else {
            return
        }

        dateComponents.day = 26
        dateComponents.hour = 23
        dateComponents.minute = 30          // 24/1/26  24시까지

        guard let maxDate = calendar.date(from: dateComponents) else {
            return
        }

        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.minuteInterval = 30      // 30분 간격
    }

    var totalAmount: Int = 0 {
        didSet {
            amountLabel.text = "\(totalAmount)원"
        }
    }

    // 좌석 선택
    func selectSeat() {
        let selectSeatStoryboard = UIStoryboard(name: "SelectSeatStoryboard", bundle: nil)

        guard let selectSeatViewController = selectSeatStoryboard.instantiateViewController(identifier: "SelectSeat") as? SelectSeatViewController else {
            return
        }
        selectSeatViewController.modalPresentationStyle = .automatic

        self.present(selectSeatViewController, animated: true)
    }


    // 결제 알림
    func paymentAlert() {
        let alertController = UIAlertController(title: "결제 확인\n", message: "결제를 진행하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if let selectedPeopleTag = peopleInfo.text,
           let selectedSeatInfo = seatInfo.text,
           let amountText = amountLabel.text {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateInfo = dateFormatter.string(from: datePicker.date)

            let confirmMessage = """
                        '\(selectedMovieTitle)'

                        날짜: \(dateInfo)
                        인원: \(selectedPeopleTag)
                        좌석: \(selectedSeatInfo)
                        총 금액: \(amountText)
                        """
            alertController.message = confirmMessage
        }

        let confirmAction = UIAlertAction(title: "결제하기", style: .default) { _ in
            self.completionAlert()
        }
        alertController.addAction(confirmAction)

        present(alertController, animated: true, completion: nil)
    }

    // 예매 완료 알림
    func completionAlert() {
        let completionAlertController = UIAlertController(title: "예매 완료", message: "예매가 완료되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        completionAlertController.addAction(okAction)
        self.present(completionAlertController, animated: true, completion: nil)

        // UserDefaults에 예매 정보 저장
        SeatData.shared.save()
    }
}
