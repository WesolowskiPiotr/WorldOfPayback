//
//  TransactionsListViewModel.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

enum Category: Int {
    case all = 0
}

protocol TransactionsFetcher {
    func fetchTransactions() async -> [Transaction]
}

@MainActor
final class TransactionsListViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var transactions: [IdentifiableTransaction] = []
    @Published var sumOfTransactions = 0
    private let transactionsFetcher: TransactionsFetcher
    
    init(
        isLoading: Bool = true,
        transactionsFetcher: TransactionsFetcher
    ) {
        self.isLoading = isLoading
        self.transactionsFetcher = transactionsFetcher
    }
    
    func fetchTransactions() async {
        transactions.removeAll()
        isLoading = true
        transactions = await transactionsFetcher.fetchTransactions().enumerated().map { (index, transaction) in
            return IdentifiableTransaction(id: index, transaction: transaction)
        } .sorted {
            guard let firstDate = DateHelper.stringToDate(
                date: $0.transaction.transactionDetail.bookingDate),
                  let secondDate = DateHelper.stringToDate(
                    date: $1.transaction.transactionDetail.bookingDate) else { return false }
            return firstDate > secondDate
        }
        sumValuesOfTransactionsWith(category: .all)
        isLoading = false
    }
    
    private func sumValuesOfTransactionsWith(category: Category) {
        sumOfTransactions = transactions.map({
            $0.transaction.transactionDetail.value.amount}).reduce(0, +)
    }
    
}
