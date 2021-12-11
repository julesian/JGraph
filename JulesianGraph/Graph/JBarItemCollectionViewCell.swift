//
//  JBarItemCollectionViewCell.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/12/21.
//

import UIKit

// TODO: Can add image instead of text for modes

class JBarItemCollectionViewCell: UICollectionViewCell {
    static let Identifier = "JBarItemCollectionViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font  = UIFont.systemFont(ofSize: 8, weight: .bold)
        label.textColor = ColorConstants.Text.Grazy
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        remakeLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(titleLabel)
    }

    private func remakeLayout() {
        remakeTitleLayout()
    }
    
    func remakeTitleLayout() {
        let view = titleLabel
        let constraints = [
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func set(title: String, highlighted: Bool) {
        titleLabel.alpha = highlighted ? 1.0 : 0.6
        titleLabel.text = title
    }
}

