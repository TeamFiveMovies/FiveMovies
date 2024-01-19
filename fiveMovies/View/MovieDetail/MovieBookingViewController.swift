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
        let alertController = UIAlertController(title: "결제 확인", message: "결제를 진행하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in

            self.dismiss(animated: true)

            // UserDefaults에 예매 정보 저장
            SeatData.shared.save()

            if let movieDetailViewController = self.navigationController?.viewControllers.first(where: { $0 is MovieDetailViewController }) as? MovieDetailViewController {
                self.navigationController?.popToViewController(movieDetailViewController, animated: true)
            }
        }
        alertController.addAction(confirmAction)

        present(alertController, animated: true, completion: nil)
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
