//
//  StringExtensions.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import Foundation

extension String {
    static func numberSuffix(from value: Double) -> String {
        var index: Int = 0
        var mutatingValue = value
        let suffixes = ["", "k", "M", "G", "T", "P", "E"]
        
        while mutatingValue >= 1000, index < suffixes.count {
            index += 1
            mutatingValue /= 1000
        }
        
        return String(format: "%.*f%@", mutatingValue < 100.0, mutatingValue, suffixes[index])
    }
}
