//
//  TransactionDetailsView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import SwiftUI

struct TransactionDetailsView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            Text(transaction.partnerDisplayName)
                .bold()
                .font(.title2)
                .lineLimit(1)
            Text(transaction.transactionDetail.description ?? .empty)
                .modifier((transaction.transactionDetail.description != nil) ?
                          DescriptionCard(color: .cyan) :
                            DescriptionCard(color: .white.opacity(StyleConstants.translucentBackgroundOpacity.rawValue)))
        }
        .navigationTitle("Transaction-List-Title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(transaction: Transaction(
            partnerDisplayName: "Name",
            alias: Alias(reference: "alias"),
            category: 1,
            transactionDetail: TransactionDetail(description: "description",
                                                 bookingDate: "",
                                                 value: Value(amount: 123, currency: "PBP"))))
    }
}
