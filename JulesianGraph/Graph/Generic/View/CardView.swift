//
//  CardView.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

class CardView: UIView {
    enum Dimensions {
        static let Padding: CGFloat = 8
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderColor = ColorConstants.Separator.cgColor
        view.layer.borderWidth = 1
        
        let layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
        
        return view
    }()

    init() {
        super.init(frame: .zero)
        setup()
        remakeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(containerView)
    }
    
    func remakeLayout() {
        let view = containerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.Padding),
            view.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.Padding),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Dimensions.Padding),
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: -Dimensions.Padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
