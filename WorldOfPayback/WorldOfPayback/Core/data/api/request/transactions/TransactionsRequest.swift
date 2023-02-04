//
//  TransactionsRequest.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

enum TransactionsRequest: RequestProtocol {
    case getTransactions

  var path: String {
    "/v2/transactions"
  }

  var urlParams: [String: String?] {
      switch self {
      case .getTransactions:
          return [:]
      }
  }

  var requestType: RequestType {
    .GET
  }
}
