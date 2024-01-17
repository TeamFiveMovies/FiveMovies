//
//  Seat.swift
//  fiveMovies
//
//  Created by Joseph on 1/16/24.
//

import Foundation

struct Seat: Codable {
    var isAvailable: Bool   // 좌석 사용 가능한지
    var isSelected: Bool    // 좌석이 선택되었는지
}
