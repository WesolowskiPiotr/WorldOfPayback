//
//  DescriptionCard.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import Foundation
import SwiftUI

struct DescriptionCard: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(color.opacity(StyleConstants.descriptionLabelBackgroundOpacity.rawValue))
            .cornerRadius(StyleConstants.cornerRadius.rawValue)
            .foregroundColor(color)
            .font(.subheadline)
    }
}
