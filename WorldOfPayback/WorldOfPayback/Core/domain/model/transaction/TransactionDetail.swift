//
//  TransactionDetail.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

struct TransactionDetail: Codable {
    let description: String?
    let bookingDate: String
    let value: Value
}
