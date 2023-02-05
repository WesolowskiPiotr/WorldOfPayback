//
//  TransactionsListView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import SwiftUI

struct TransactionsListView: View {
    @ObservedObject var viewModel: TransactionsListViewModel
    @ObservedObject var monitor = NetworkMonitor()
    
    @State private var settingsIsPresented = false
    
    var body: some View {
        NavigationView {
            if monitor.isConnected {
                List {
                    HStack{
                        Text("Transactions-Sum")
                            .bold()
                            .font(.title2)
                            .lineLimit(1)
                        Text("\(viewModel.sumOfTransactions)")
                            .modifier(TransactionSum(color: .orange))
                    }
                    ForEach(viewModel.transactions, id: \.id) { item in
                        let transaction = item.transaction
                        NavigationLink(destination: TransactionDetailsView(transaction: transaction)) {
                            TransactionsRawView(transaction: transaction)
                        }
                    }
                }
                .task {
                    if viewModel.transactions.isEmpty {
                        await viewModel.fetchTransactions()
                    }
                }
                .listRowSeparator(.hidden)
                .navigationTitle("Transaction-List-Title")
                .overlay {
                    if viewModel.isLoading {
                        ProgressView("Fetching-Transactions-Text")
                    }
                }
            } else {
                InternetConnectionView()
                    .navigationTitle("Transaction-List-Title")
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
