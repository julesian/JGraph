//
//  ColorConstants.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

enum ColorConstants {
    enum Text {
        // Mistyped, but liked the name
        static let Grazy = UIColor(hex: "#9A9A9A")
    }
    
    enum Level {
        static let One = [
            UIColor(hex: "#F384A5"),
            UIColor(hex: "#CA6E89")
        ]
        static let Two = [
            UIColor(hex: "#9D86F5"),
            UIColor(hex: "#806ECA")
        ]
        static let Three = [
            UIColor(hex: "#D886F5"),
            UIColor(hex: "#C177DB")
        ]
        static let Four = [
            UIColor(hex: "#CBE8C8"),
            UIColor(hex: "#85CBA6")
        ]
    }
    
    enum Bar {
        static let Border = UIColor(hex: "#CACACA")
        static let HighlightBorder = UIColor(hex: "#EFEFEF")
        static let HighlightBackground = UIColor(hex: "#F8F8F8")
    }
    
    static let Separator = UIColor(hex: "#F0F0F0")
}
