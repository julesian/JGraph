//
//  JBarCollectionViewCell.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

class JBarCollectionViewCell: UICollectionViewCell {
    static let Identifier = "JBarCollectionViewCell"
    
    lazy var barContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var barView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    var isBarHighlighted = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        remakeLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(barContainerView)
        barContainerView.addSubview(barView)
    }

    private func remakeLayout() {
        remakeContainerLayout()
        remakeBarLayout()
    }
    
    func remakeContainerLayout() {
        let view = barContainerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeBarLayout() {
        let view = barView
        let container = barContainerView
        var constraints = [
            view.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ]
        
        let barHeightConstraint = view.heightAnchor.constraint(equalToConstant: 0)
        constraints.append(barHeightConstraint)
        self.barHeightConstraint = barHeightConstraint
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setLevel(_ level: Int) {
        barView.setColors(ColorHelper.barColors(from: level))
    }
    
    func setBarHighlighted(_ highlighted: Bool) {
        isBarHighlighted = highlighted
        
        let container = barContainerView
        
        if isBarHighlighted {
            let layer = container.layer
            
            layer.borderWidth = 0.5
            layer.borderColor = ColorConstants.Bar.HighlightBorder.cgColor
            layer.roundCorners(at: [.topRight, .topLeft], radius: 4.0, bounds: bounds)
            
            barContainerView.backgroundColor = ColorConstants.Bar.HighlightBackground
        } else {
            layer.borderWidth = 0.0
            barContainerView.backgroundColor = .clear
        }
    }
    
    func setBarPercentage(_ percentage: CGFloat) {
        let barHeight = barContainerView.bounds.height
        let adjustedHeight = barHeight * percentage
        
        barHeightConstraint?.constant = adjustedHeight
    }
    
    func setAnimatedBarPercentage(_ percentage: CGFloat, delay: CGFloat) {
        self.animateBarPercentage(percentage, delay: delay)
    }
    
    func animateBarPercentage(_ percentage: CGFloat, delay: CGFloat) {
        let barHeight = barContainerView.bounds.height
        let adjustedHeight = barHeight * percentage
        
        barHeightConstraint?.constant = 0.0
        
        UIView.animate(withDuration: 1.0,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
            self.barHeightConstraint?.constant = adjustedHeight
            self.barContainerView.layoutIfNeeded()
        }, completion: nil)
    }
}
