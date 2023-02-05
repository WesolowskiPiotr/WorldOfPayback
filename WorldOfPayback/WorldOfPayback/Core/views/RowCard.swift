//
//  RowCard.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import Foundation
import SwiftUI

struct RowCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 70)
            .listRowSeparator(.hidden)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            )
    }
}
