//
//  APIConstants.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 04/02/2023.
//

import Foundation

enum APIConstants {
#if PRODUCTION
    static let host = "https://api.payback.com/transactions"
#else
    static let host = "https://api-test.payback.com/transactions"
#endif
    
    static let grantType = "client_credentials"
    static let clientId = "FUTURE_CLIENT_ID"
    static let clientSecret = "FUTURE_CLIENT_SECRET"
}
