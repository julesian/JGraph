//
//  CALayerExtensions.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/12/21.
//

import UIKit

extension CALayer {
    func roundCorners(at corners: UIRectCorner, radius: CGFloat, bounds: CGRect) {
        let cornerRadii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: cornerRadii)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.mask = mask
    }
}
