//
//  JBarGraphValueIndicatorView.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/12/21.
//

import UIKit

class JBarGraphIndicatorView: UIView {
    
    lazy var indicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .right
        label.textColor = ColorConstants.Text.Grazy
        return label
    }()
    
    var value: String
    var originalCenter: CGPoint?
    
    init(value: String) {
        self.value = value
        
        super.init(frame: .zero)
        setup()
        remakeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicatorLabel)
    }
    
    func remakeLayout() {
        remakeIndicatorLabelLayout()
    }
    
    func remakeIndicatorLabelLayout() {
        let view = indicatorLabel
        let constraints = [
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        originalCenter = center
        indicatorLabel.text = value
    }
    
    func animateShow(_ show: Bool, delay: CGFloat) {
        let offset = 12.0
        let initialOffset = show ? offset : 0
        guard let center = originalCenter
        else {
            return
        }
        self.isHidden = false
        self.center = CGPoint(x: center.x + initialOffset, y: center.y)
        
        alpha = show ? 0 : 0.6
        
        UIView.animate(withDuration: 1.0,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
            let targetOffset = show ? 0 : offset
            self.center = CGPoint(x: center.x + targetOffset, y: center.y)
            
            self.alpha = show ? 0.6 : 0
            
            self.layoutIfNeeded()
        }, completion: { _ in
            self.isHidden = !show
        })
    }
    
}
