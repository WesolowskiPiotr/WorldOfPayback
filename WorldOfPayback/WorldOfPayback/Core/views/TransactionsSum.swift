//
//  TransactionsSum.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import Foundation
import SwiftUI

struct TransactionSum: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(color.opacity(StyleConstants.descriptionLabelBackgroundOpacity.rawValue))
            .cornerRadius(StyleConstants.cornerRadius.rawValue)
            .foregroundColor(color)
            .bold()
            .font(.title2)
            .lineLimit(1)
    }
}

