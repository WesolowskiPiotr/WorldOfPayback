//
//  TransactionsListViewModelTestCase.swift
//  WorldOfPaybackTests
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import Foundation
import XCTest
@testable import WorldOfPayback

@MainActor
final class TransactionsListViewModelTestCase: XCTestCase {
    var viewModel: TransactionsListViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = TransactionsListViewModel(transactionsFetcher: TransactionsFetcherMock())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchTransactionsLoadingState() async {
        XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
        await viewModel.fetchTransactions()
        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
    }
    
    func testSumValuesOfAllTransactions() async {
        // Given
        let sumOfAllMockedTransactions = 5770
        
        // When
        await viewModel.fetchTransactions()
        
        // Then
        XCTAssertEqual(viewModel.sumOfTransactions, sumOfAllMockedTransactions)
    }
    
    func testSumValuesOfFilteredTransactions() async {
        // Given
        let sumOfAllMockedTransactionsWith_1_Category = 2711
        
        // When
        await viewModel.fetchTransactions()
        viewModel.filterTransactionsWith(category: 1)
        
        // Then
        XCTAssertEqual(viewModel.sumOfTransactions, sumOfAllMockedTransactionsWith_1_Category)
    }
    
    func testFetchTransactionsProvideCategoriesForNonEmptyResponse() async {
        // When
        await viewModel.fetchTransactions()
        
        // Then
        XCTAssertTrue(!viewModel.transactionsCategories.isEmpty, "The view model shouldn has categories, but it isn't")
    }
}
