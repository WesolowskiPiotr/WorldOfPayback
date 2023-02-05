//
//  TransactionsListViewModel.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

protocol TransactionsFetcher {
    func fetchTransactions() async -> [Transaction]
}

@MainActor
final class TransactionsListViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var transactions: [IdentifiableTransaction] = []
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
        }
        isLoading = false
    }
    
}
