//
//  ColorHelper.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

struct ColorHelper {
    static func barColors(from level: Int) -> [UIColor] {
        switch level {
        case 0: return ColorConstants.Level.One
        case 1: return ColorConstants.Level.Two
        case 2: return ColorConstants.Level.Three
        case 3: return ColorConstants.Level.Four
        default: return ColorConstants.Level.One
        }
    }
    
    static func levelColor(from level: Int) -> UIColor {
        switch level {
        case 0: return ColorConstants.Level.One[0]
        case 1: return ColorConstants.Level.Two[0]
        case 2: return ColorConstants.Level.Three[0]
        case 3: return ColorConstants.Level.Four[0]
        default: return ColorConstants.Level.One[0]
        }
    }
}
