//
//  TestDataHelper.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/12/21.
//

import Foundation

struct TestDataHelper {
    static func properties() -> JBarGraphProperties {
        let properties = JBarGraphProperties()
        
        properties.minValue = 0
        properties.maxValue = 10000
        properties.roundToNearest = 1000
        properties.targetValue = 1000
        properties.items = items()
        properties.levels = levels()
        
        return properties
    }
    
    private static func items() -> [JBarGraphItem] {
        var items = [JBarGraphItem]()
        
        for i in 0...7 {
            let randomInt = arc4random_uniform(10000)
            let item = JBarGraphItem()
            item.value = Double(randomInt)
            item.title = String(format: "%d", i + 1)
            items.append(item)
        }
        
        return items
    }
    
    private static func levels() -> [JBarGraphLevel] {
        return [
            level(title: "LOW", min: 0.0, max: 2499.0, level: 0),
            level(title: "MEDIUM", min: 2500.0, max: 7499.0, level: 1),
            level(title: "HIGH", min: 7500.0, max: 0, level: 2)
            ]
    }
    
    private static func level(title: String, min: Double, max: Double, level: Int) -> JBarGraphLevel {
        let jLevel = JBarGraphLevel()
        
        jLevel.title = title
        
        let hasNoLimit = min > max || max == 0
        
        jLevel.subtitle = hasNoLimit ?
        String(format: "%@+",
               String.numberSuffix(from: min))
        :
        String(format: "%@ - %@",
               String.numberSuffix(from: min),
               String.numberSuffix(from: max))
        jLevel.minValue = min
        jLevel.maxValue = max
        jLevel.level = level
        
        return jLevel
    }
}
