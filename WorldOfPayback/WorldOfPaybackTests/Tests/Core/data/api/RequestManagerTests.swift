//
//  RequestManagerTests.swift
//  WorldOfPaybackTests
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import XCTest
@testable import WorldOfPayback

class RequestManagerTests: XCTestCase {
  private var requestManager: RequestManagerProtocol?

  override func setUp() {
    super.setUp()
    guard let userDefaults = UserDefaults(suiteName: #file) else { return }
    userDefaults.removePersistentDomain(forName: #file)
    requestManager = RequestManagerMock(
      apiManager: APIManagerMock(),
      accessTokenManager: AccessTokenManager(userDefaults: userDefaults)
    )
  }

  func testRequestTransactions() async throws {
      guard let container: TransactionsContainer =
                 try await requestManager?.perform(TransactionsRequestMock.getTransactions) else { return }
      let first = container.items.first
      let last = container.items.last
      XCTAssertEqual(first?.partnerDisplayName, "REWE Group")
      XCTAssertEqual(first?.category, 1)
      XCTAssertEqual(first?.transactionDetail.description, "Punkte sammeln")
      XCTAssertEqual(first?.transactionDetail.bookingDate, "2022-07-24T10:59:05+0200")
      XCTAssertEqual(first?.transactionDetail.value.amount, 124)
      XCTAssertEqual(first?.transactionDetail.value.currency, "PBP")
      
      XCTAssertEqual(last?.partnerDisplayName, "Saturn")
      XCTAssertEqual(last?.category, 2)
      XCTAssertEqual(last?.transactionDetail.description, "Punkte sammeln")
      XCTAssertEqual(last?.transactionDetail.bookingDate, "2022-12-01T10:59:05+0200")
      XCTAssertEqual(last?.transactionDetail.value.amount, 129)
      XCTAssertEqual(last?.transactionDetail.value.currency, "PBP")
  }
}
