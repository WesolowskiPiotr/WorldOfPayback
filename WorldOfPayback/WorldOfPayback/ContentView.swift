//
//  ContentView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
//        VStack {
//            Text("URL: \(APIConstants.host)")
//            Text(NSLocalizedString("test_text.label", comment: ""))
//        }
//        .padding()
        TransactionsListView(viewModel: TransactionsListViewModel(transactionsFetcher: TransactionsFetcherMock()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
