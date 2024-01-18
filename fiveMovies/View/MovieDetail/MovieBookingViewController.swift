//
//  MovieBookingViewController.swift
//  fiveMovies
//
//  Created by 홍희곤 on 1/16/24.
//

import UIKit

class MovieBookingViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var peopleInfo: UILabel!
    @IBOutlet weak var seatInfo: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        SeatData.shared.load()

        setupDatePicker()
    }

    @IBAction func checkOutBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true)

        //UserDefaults에 예매정보 저장
        SeatData.shared.save()
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

}
