//
//  ContentView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    #if PRODUCTION
    let APIUrl = "https://api.payback.com/transactions"
    #else
    let APIUrl = "https://api-test.payback.com/transactions"
    #endif
    
    var body: some View {
        VStack {
            Text("URL: \(APIUrl)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
