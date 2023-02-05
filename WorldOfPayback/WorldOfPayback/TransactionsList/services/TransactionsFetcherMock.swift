//
//  TransactionsFetcherMock.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

struct TransactionsFetcherMock: TransactionsFetcher {
    func fetchTransactions() async -> [Transaction] {
        let seconds = Int.random(in: 1...2)
        let duration = UInt64(seconds * 1_000_000_000)
        
        //let simulateFail = Int.random(in: 1...100)
        //print("Fail simulation")
        
        do {
            try await Task.sleep(nanoseconds: duration)
            //if simulateFail > 90 {
            //    throw NetworkError.invalidServerResponse
            //}
            
            return Transaction.mock
        } catch {
            switch error as? NetworkError {
            case .invalidServerResponse, .invalidURL, .none:
                return []
            }
        }
    }
}
