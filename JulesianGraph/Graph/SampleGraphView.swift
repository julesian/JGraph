//
//  SampleGraphView.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/12/21.
//

import Foundation

import UIKit

class SampleGraphView: UIView {
    
    enum Dimensions {
        static let CardPadding = 8.0
        static let TextPadding = 14.0
    }
    
    enum Constants {
        static let Title = "Monthly MMR"
    }
    
    lazy var cardView = CardView()
    lazy var barGraphView = JBarGraphView()
    
    lazy var properties = JBarGraphProperties()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font  = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = ColorConstants.Text.Grazy
        label.textAlignment = .left
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
        remakeLayout()
    }
    
    func set(properties: JBarGraphProperties) {
        self.properties = properties
        barGraphView.set(properties: properties)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cardView)
        cardView.containerView.addSubview(barGraphView)
        cardView.containerView.addSubview(titleLabel)
    }
    
    func remakeLayout() {
        remakeBarGraphCardViewLayout()
        remakeBarGraphView()
        remakeTitleLabelLayout()
    }
    
    func remakeBarGraphCardViewLayout() {
        let view = cardView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeBarGraphView() {
        let view = barGraphView
        let container = cardView.containerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Dimensions.CardPadding),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: Dimensions.CardPadding),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Dimensions.CardPadding),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Dimensions.CardPadding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeTitleLabelLayout() {
        let view = titleLabel
        let container = cardView.containerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Dimensions.TextPadding),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: Dimensions.TextPadding),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Dimensions.TextPadding)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
