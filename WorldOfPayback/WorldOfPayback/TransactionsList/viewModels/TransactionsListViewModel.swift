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
    @Published var filteredTransactions: [IdentifiableTransaction] = []
    @Published var sumOfTransactions = 0
    @Published var transactionsCategories: [Int] = []
    
    private let transactionsFetcher: TransactionsFetcher
    
    var categorySelection = Category.all.rawValue
    var fetchedTransactions: [IdentifiableTransaction] = []
    
    init(
        isLoading: Bool = true,
        transactionsFetcher: TransactionsFetcher
    ) {
        self.isLoading = isLoading
        self.transactionsFetcher = transactionsFetcher
    }
    
    func fetchTransactions() async {
        clear()
        
        fetchedTransactions = await transactionsFetcher.fetchTransactions().enumerated().map { (index, transaction) in
            return IdentifiableTransaction(id: index, transaction: transaction)
        }
        .sorted {
            guard let firstDate = DateHelper.stringToDate(
                date: $0.transaction.transactionDetail.bookingDate),
                  let secondDate = DateHelper.stringToDate(
                    date: $1.transaction.transactionDetail.bookingDate) else { return false }
            return firstDate > secondDate
        }
        
        filteredTransactions = fetchedTransactions
        
        sumValuesOfTransactionsWith(category: Category.all.rawValue)
        fetchCategories()
    }
    
    func filterTransactionsWith(category: Int = Category.all.rawValue) {
        filteredTransactions.removeAll()
        isLoading = true
        
        if category == Category.all.rawValue {
            filteredTransactions = fetchedTransactions
        } else {
            filteredTransactions = fetchedTransactions.filter { $0.transaction.category == category }
        }
        
        sumValuesOfTransactionsWith(category: category)
        isLoading = false
        categorySelection = category
    }
    
    private func sumValuesOfTransactionsWith(category: Category.RawValue) {
        sumOfTransactions = filteredTransactions.map({
            $0.transaction.transactionDetail.value.amount}).reduce(0, +)
    }
    
    private func fetchCategories() {
        var categories = fetchedTransactions.map {
            $0.transaction.category
        }
        categories.append(Category.all.rawValue)
        transactionsCategories = categories.removingDuplicates().sorted()
        isLoading = false
    }
    
    private func clear() {
        isLoading = true
        fetchedTransactions.removeAll()
        categorySelection = Category.all.rawValue
    }
}
