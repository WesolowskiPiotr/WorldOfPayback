//
//  TransactionMock.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

// MARK: - Mock data
extension Transaction {
  static let mock = loadTransactions()
}

private struct TransactionMock: Codable {
  let items: [Transaction]
}

private func loadTransactions() -> [Transaction] {
  guard let url = Bundle.main.url(forResource: "PBTransactions", withExtension: "json"),
    let data = try? Data(contentsOf: url) else { return [] }
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let jsonMock = try decoder.decode(TransactionMock.self, from: data)
        return jsonMock.items
    } catch DecodingError.keyNotFound(let key, let context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch {
        print(error.localizedDescription)
    }
    return []
}
