//
//  JBarGraphLevelView.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/11/21.
//

import UIKit

class JBarGraphLevelView: UIView {
    
    enum Dimensions {
        static let PointerWidth = 3.0
        static let PointerHeight = 12.0
        static let Height = 40.0
        static let Padding = 2.0
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1.0
        return view
    }()
    
    lazy var highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font  = UIFont.systemFont(ofSize: 8, weight: .bold)
        label.textColor = ColorConstants.Text.Grazy
        label.textAlignment = .center
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var pointerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "icon_pointer")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var level: JBarGraphLevel
    var index: Double
    var originalCenter: CGPoint?
    var animateOnLoad = false
    var didLayoutSubviews = false
    
    init(level: JBarGraphLevel, index: Double) {
        self.level = level
        self.index = index
        
        super.init(frame: .zero)
        setup()
        remakeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        addSubview(pointerImageView)
        containerView.addSubview(highlightView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
    }
    
    func remakeLayout() {
        remakeViewLayout()
        remakeContainerViewLayout()
        remakeHighlightViewLayout()
        remakePointerLayout()
        remakeTitleLayout()
        remakeSubtitleLayout()
    }
    
    func remakeViewLayout() {
        let constraints = [
            heightAnchor.constraint(equalToConstant: Dimensions.Height)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeHighlightViewLayout() {
        let view = highlightView
        let container = containerView
        let constraints = [
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeContainerViewLayout() {
        let view = containerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Dimensions.PointerWidth - 1)),
            view.centerYAnchor.constraint(equalTo: pointerImageView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeTitleLayout() {
        let view = titleLabel
        let container = containerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: Dimensions.Padding),
            view.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeSubtitleLayout() {
        let view = subtitleLabel
        let container = containerView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakePointerLayout() {
        let view = pointerImageView
        let constraints = [
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: Dimensions.PointerHeight),
            view.widthAnchor.constraint(equalToConstant: Dimensions.PointerWidth)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        originalCenter = center
        titleLabel.text = level.title
        subtitleLabel.text = level.subtitle
        
        let color = ColorHelper.levelColor(from: level.level)
        pointerImageView.tintColor = color
        containerView.layer.borderColor = color.cgColor
        containerView.backgroundColor = color
        
        if !didLayoutSubviews {
            layoutIfNeeded()
            didLayoutSubviews = true
        }
        
        if didLayoutSubviews, animateOnLoad {
            animateShow(true, delay: index * 0.15)
        }
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
        
        alpha = show ? 0 : 1
        
        UIView.animate(withDuration: 1.0,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
            let targetOffset = show ? 0 : offset
            self.center = CGPoint(x: center.x + targetOffset, y: center.y)
            
            self.alpha = show ? 1 : 0
            
            self.layoutIfNeeded()
        }, completion: { _ in
            self.isHidden = !show
        })
    }
    
}
