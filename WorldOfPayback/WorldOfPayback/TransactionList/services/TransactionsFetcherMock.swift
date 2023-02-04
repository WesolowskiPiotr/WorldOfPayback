//
//  TransactionsFetcherMock.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

struct TransactionsFetcherMock: TransactionsFetcher {
    func fetchTransactions() async -> [Transaction] {
        Thread.sleep(forTimeInterval: 2)
        return Transaction.mock
    }
}
