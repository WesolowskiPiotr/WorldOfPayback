//
//  APIManagerMock.swift
//  WorldOfPaybackTests
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import XCTest
@testable import WorldOfPayback

struct APIManagerMock: APIManagerProtocol {
  func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
      return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
  }

  func requestToken() async throws -> Data {
    Data(AccessTokenTestHelper.generateValidToken().utf8)
  }
}
