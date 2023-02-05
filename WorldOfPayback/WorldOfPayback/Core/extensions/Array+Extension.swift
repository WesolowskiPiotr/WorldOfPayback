//
//  Array+Extension.swift
//  WorldOfPayback
//
//  Created by Piotr Wesołowski on 05/02/2023.
//

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
