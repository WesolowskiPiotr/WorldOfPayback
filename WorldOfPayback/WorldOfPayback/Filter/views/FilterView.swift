//
//  SearchFilterView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State var selectedCategory: Int
    let categories: [Int]
    let performSelection: (Int) -> Void
    
    var body: some View {
        Form {
            Section {
                Picker("Category-Section-Title", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text(String($0))
                    }
                }
                .onChange(of: selectedCategory) { _ in
                    performSelection(selectedCategory)
                    dismiss()
                }
            }  footer: {
                Text("Category-Section-Footer")
            }
            
            Button("Search-Filter-View-Clear-Button", role: .destructive) {
                selectedCategory = 0
            }
        }
        .navigationBarTitle("Search-Filter-View-Title")
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                }
            }
        }
    }
}
