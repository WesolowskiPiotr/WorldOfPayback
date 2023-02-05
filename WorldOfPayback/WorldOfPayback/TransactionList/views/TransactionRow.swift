//
//  TransactionRow.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import SwiftUI

struct TransactionsRawView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.partnerDisplayName)
                    .bold()
                    .font(.title2)
                    .lineLimit(2)
                    .frame(alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text(transaction.transactionDetail.bookingDate)
                    .font(.headline)
                    .foregroundColor(.green)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .fixedSize(horizontal: true, vertical: false)
            }
            Spacer()
            HStack {
                Text(transaction.transactionDetail.description ?? .empty)
                    .modifier((transaction.transactionDetail.description != nil) ?
                              DescriptionCard(color: .cyan) :
                                DescriptionCard(color: .white.opacity(StyleConstants.translucentBackgroundOpacity.rawValue)))
                Spacer()
                HStack {
                    Text(String(transaction.transactionDetail.value.amount))
                        .bold()
                        .font(.title2)
                        .lineLimit(1)
                    Text(transaction.transactionDetail.value.currency)
                        .bold()
                        .font(.title3)
                        .lineLimit(1)
                }
            }
        }
        .modifier(RowCard())
    }
}

struct TransactionsRawViewView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsRawView(transaction: Transaction(
            partnerDisplayName: "Name",
            alias: Alias(reference: "alias"),
            category: 1,
            transactionDetail: TransactionDetail(description: "description",
                                                 bookingDate: "",
                                                 value: Value(amount: 123, currency: "PBP"))))
    }
}
