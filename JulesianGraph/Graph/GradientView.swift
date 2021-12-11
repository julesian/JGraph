//
//  GradientView.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

class GradientView: UIView {
    var colors = [UIColor]()
    var cgColors = [CGColor]()
    var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.borderColor = ColorConstants.Bar.Border.cgColor
        gradientLayer.borderWidth = 0.5
        
        layer.addSublayer(gradientLayer)
    }
    
    func setColors(_ colors: [UIColor]) {
        self.colors = colors
        cgColors = cgColors(from: colors)
        updateGradients()
    }
    
    func cgColors(from colors: [UIColor]) -> [CGColor] {
        var cgColors = [CGColor]()
        for color in colors {
            cgColors.append(color.cgColor)
        }
        return cgColors
    }
    
    func setAnimatedColors(_ colors: [UIColor], duration: CGFloat) {
        layer.removeAllAnimations()
        setColors(colors)
        updateGradients()
        
        let animation = CABasicAnimation(keyPath: "color_shift")
        animation.toValue = cgColors
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "color_shift_animation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradients()
    }
    
    func updateGradients() {
        gradientLayer.colors = cgColors
        gradientLayer.frame = bounds
        gradientLayer.roundCorners(at: [.topRight, .topLeft], radius: 4.0, bounds: bounds)
    }
}

