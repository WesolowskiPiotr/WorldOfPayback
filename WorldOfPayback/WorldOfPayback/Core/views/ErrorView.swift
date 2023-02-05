//
//  EmptyTransactionsFetch.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import SwiftUI

struct ErrorView: View {
    var fetchTransactions: () async -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .font(.system(size: 56))
            Text("Empty-Transactions-List-Message")
                .padding()
            Button("Perform-Network-Request") {
                Task {
                    await fetchTransactions()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
