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
    @State private var filterPickerIsPresented = false
    
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
                    ForEach(viewModel.filteredTransactions, id: \.id) { item in
                        let transaction = item.transaction
                        NavigationLink(destination: TransactionDetailsView(transaction: transaction)) {
                            TransactionsRawView(transaction: transaction)
                        }
                    }
                }
                .task {
                    if viewModel.fetchedTransactions.isEmpty {
                        await viewModel.fetchTransactions()
                    } else if viewModel.categorySelection != Category.all.rawValue {
                        viewModel.filterTransactionsWith(category: viewModel.categorySelection)
                    } else {
                        viewModel.filterTransactionsWith()
                    }
                }
                .refreshable {
                    await viewModel.fetchTransactions()
                }
                .listRowSeparator(.hidden)
                .navigationTitle("Transaction-List-Title")
                .toolbar {
                    ToolbarItem {
                        Button {
                            filterPickerIsPresented.toggle()
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                        }
                        .sheet(isPresented: $filterPickerIsPresented) {
                            NavigationView {
                                FilterView(
                                    selectedCategory: viewModel.categorySelection,
                                    categories: viewModel.transactionsCategories,
                                    performSelection: viewModel.filterTransactionsWith(category:))
                            }
                        }
                    }
                }
                .overlay {
                    if viewModel.isLoading && viewModel.fetchedTransactions.isEmpty {
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
}

struct TransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView(viewModel: TransactionsListViewModel(transactionsFetcher: TransactionsFetcherMock()))
    }
}
