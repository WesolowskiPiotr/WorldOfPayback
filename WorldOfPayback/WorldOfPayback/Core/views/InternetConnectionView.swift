//
//  InternetConnectionView.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import SwiftUI

struct InternetConnectionView: View {
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false
    
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
                .font(.system(size: 56))
            Text("Not-Connected-Text")
                .padding()
            Button("Perform-Network-Request") {
                self.showAlertSheet = true
            }
        }
        .alert(isPresented: $showAlertSheet, content: {
            if monitor.isConnected {
                return Alert(title: Text("Is-Connected-Alert-Title"),
                             message: Text("Is-Connected-Alert-Message"),
                             dismissButton: .default(Text("Is-Connected-Alert-Button-Text")))
            }
            return Alert(title: Text("Not-Connected-Alert-Title"),
                         message: Text("Not-Connected-Alert-Message"),
                         dismissButton: .default(Text("Not-Connected-Alert-Button-Text")))
        })
    }
}

struct InternetConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        InternetConnectionView()
    }
}
