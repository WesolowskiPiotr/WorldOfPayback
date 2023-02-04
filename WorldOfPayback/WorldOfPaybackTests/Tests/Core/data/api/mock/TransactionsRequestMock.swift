//
//  TransactionsRequestMock.swift
//  WorldOfPaybackTests
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation
@testable import WorldOfPayback

enum TransactionsRequestMock: RequestProtocol {
  case getTransactions

  var requestType: RequestType {
    return .GET
  }

  var path: String {
    guard let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json") else { return "" }
    return path
  }
}
