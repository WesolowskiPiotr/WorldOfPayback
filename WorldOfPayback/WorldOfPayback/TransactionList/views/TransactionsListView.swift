//
//  TransactionsListView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import SwiftUI

struct TransactionsListView: View {
    @ObservedObject var viewModel: TransactionsListViewModel
    @State var settingsIsPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.transactions, id: \.id) { transaction in
                    Text(transaction.transaction.partnerDisplayName)
                }
            }
            .task {
                await viewModel.fetchTransactions()
            }
            .listStyle(.plain)
            .navigationTitle("Transactions")
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Fetching transactions...")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func presentSettings() {
        settingsIsPresented.toggle()
    }
}

struct TransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView(viewModel: TransactionsListViewModel(transactionsFetcher: TransactionsFetcherMock()))
    }
}
