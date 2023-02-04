//
//  IdentifiableTransaction.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

struct IdentifiableTransaction: Codable {
    var id = Int.random(in: Int.min...Int.max)
    let transaction: Transaction
}

// MARK: - Identifiable
extension IdentifiableTransaction: Identifiable {
}
