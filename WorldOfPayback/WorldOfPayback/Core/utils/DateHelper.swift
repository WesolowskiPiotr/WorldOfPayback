//
//  DateHelper.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

import Foundation

final class DateHelper {
    enum DateFormatType: String {
        case apiFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        case userFriendly = "MMM d yyyy HH:mm:ss"
    }
    
    static func stringToDate(date: String) -> Date? {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = DateFormatType.userFriendly.rawValue
        guard let formattedDate = dfmatter.date(from: date) else { return nil }
        return formattedDate
    }
    
    static func dateStringWithFormat(date: String, formatType: DateFormatType) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = DateFormatType.apiFormat.rawValue
        guard let date = dateFormatterGet.date(from: date) else { return .empty }
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = formatType.rawValue
        return dfmatter.string(from: date)
    }
}

