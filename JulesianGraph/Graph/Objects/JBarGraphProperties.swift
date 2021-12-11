//
//  JBarGraphProperties.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

class JBarGraphProperties: NSObject {
    enum Defaults {
        static let MinValue: Double = 0
        static let MaxValue: Double = 10000
        static let NearestRound: Double = 1000
        static let Target: Double = 8000
    }
    
    var minValue: Double = Defaults.MinValue
    var maxValue: Double = Defaults.MaxValue
    var roundToNearest: Double = Defaults.NearestRound
    var targetValue: Double = Defaults.Target
    
    var items = [JBarGraphItem]()
    var levels = [JBarGraphLevel]()
    
    var barGradientColors = [UIColor]()
}

// Logic
extension JBarGraphProperties {
    /// Update current item levels
    func updateItemLevels() {
        for item in items{
            var currentLevel = 0
            for level in levels {
                if item.value >= level.minValue,
                   item.value <= level.maxValue {
                        item.level = currentLevel;
                }
                currentLevel += 1
            }
        }
    }
    
    /// Determines the max value
    func updateMaxValue() {
        var maxValue: Double  = 0
        for item in items {
            if item.value > maxValue {
                maxValue = item.value
            }
        }
        
        for level in levels {
            if level.minValue > maxValue {
                maxValue = level.minValue
            }
        }
        
        let round = roundToNearest
        maxValue = round * ceil((maxValue / round) + 0.5)
        
        maxValue = maxValue < self.maxValue ? self.maxValue : maxValue
        
        minValue = 0
        self.maxValue = maxValue
    }
    
    // TODO: document params
    func getValueIndicator(at index: Int, count: Int) -> String {
        let index = Double(index)
        let count = Double(count)
        let value = maxValue - (index * (maxValue * (1.0 / count)))
        return String(format: "%.0f", value)
    }
}
