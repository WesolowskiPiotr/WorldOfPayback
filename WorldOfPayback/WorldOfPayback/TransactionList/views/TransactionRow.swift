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
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.partnerDisplayName)
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                Spacer()
                Text(transaction.transactionDetail.description ?? .empty)
                    .modifier((transaction.transactionDetail.description != nil) ?
                              DescriptionCard(color: .cyan) :
                                DescriptionCard(color: .white.opacity(StyleConstants.translucentBackgroundOpacity.rawValue)))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(transaction.transactionDetail.bookingDate)
                    .font(.title3)
                    .foregroundColor(.green)
                    .lineLimit(1)
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
            .frame(width: 185)
        }
        .modifier(RowCard())
        .background(.gray.opacity(StyleConstants.transactionRowBackgroundOpacity.rawValue))
        .cornerRadius(StyleConstants.cornerRadius.rawValue)
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
