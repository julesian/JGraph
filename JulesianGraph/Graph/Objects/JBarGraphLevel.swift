//
//  JBarGraphLevel.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import Foundation
import UIKit

class JBarGraphLevel: NSObject {
    enum Defaults {
        static let MinValue: Double = 0
        static let MaxValue: Double = 10000
        static let Title = "Title"
        static let SubTitle = "SubTitle"
        static let Level: Int = 0
    }
    
    var minValue: Double = Defaults.MinValue
    var maxValue: Double = Defaults.MaxValue
    var title: String = Defaults.Title
    var subtitle: String = Defaults.SubTitle
    var level: Int = Defaults.Level
}
