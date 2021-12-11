//
//  JBarGraphItem.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import Foundation

class JBarGraphItem: NSObject {
    enum Defaults {
        static let Value: Double = 0
        static let Title = "Item"
        static let Level: Int = 0
    }
    
    var value: Double = Defaults.Value
    var title: String = Defaults.Title
    var level: Int = Defaults.Level
}
