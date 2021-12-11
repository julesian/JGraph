//
//  JBarGraphView.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/10/21.
//

import UIKit

class JBarGraphView: UIView {
    
    // MARK: UI
    
    enum Dimensions {
        static let TopPadding: CGFloat = 48
        static let BottomPadding: CGFloat = 0
        static let HorizontalSpacing: CGFloat = 8
        static let BarSpacing: CGFloat = 8
    }
    
    enum Constants {
        /// number that divides the y axis into slices, ie if the max 
        static let ValueIndicatorCount = 4
    }
    
    lazy var barCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JBarCollectionViewCell.self,
                                forCellWithReuseIdentifier: JBarCollectionViewCell.Identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JBarItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: JBarItemCollectionViewCell.Identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstants.Separator
        return view
    }()
    
    lazy var yContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var yLevelViews = [JBarGraphLevelView]()
    var yIndicatorViews = [JBarGraphIndicatorView]()

    // MARK: Properties
    var properties: JBarGraphProperties
    
    // TODO: temporary flag
    var isShowingLevels = true
    var didLayoutSubviews = false
    
    // MARK: Init & Setup
    
    init() {
        properties = JBarGraphProperties()
        super.init(frame: .zero)
        setup()
        remakeLayout()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(barCollectionView)
        addSubview(yContentView)
        addSubview(itemCollectionView)
        addSubview(separator)
    }
    
    func remakeLayout() {
        remakeBarCollectionViewLayout()
        remakeVerticalContentLayout()
        remakeHorizontalContentLayout()
        remakeSeparatorLayout()
    }
    
    func remakeBarCollectionViewLayout() {
        let view = barCollectionView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: yContentView.trailingAnchor, constant: Dimensions.HorizontalSpacing),
            view.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.TopPadding),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeVerticalContentLayout() {
        let view = yContentView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.TopPadding),
            view.bottomAnchor.constraint(equalTo: barCollectionView.bottomAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeHorizontalContentLayout() {
        let view = itemCollectionView
        let constraints = [
            view.leadingAnchor.constraint(equalTo: barCollectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: barCollectionView.bottomAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Dimensions.BottomPadding),
            view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func remakeSeparatorLayout() {
        let view = separator
        let constraints = [
            view.topAnchor.constraint(equalTo: itemCollectionView.topAnchor),
            view.leadingAnchor.constraint(equalTo: yContentView.trailingAnchor),
            view.trailingAnchor.constraint(equalTo: itemCollectionView.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didLayoutSubviews {
            setupYContainerView()
            setupYLevelViews()
            
            didLayoutSubviews = true
        }
    }
    
    // MARK: Y Value Indicators
    
    // TOOD: setup states / modes for Y axis
    func setupYContainerView() {
        for index in 0...Constants.ValueIndicatorCount {
            let value = properties.getValueIndicator(at: index, count: Constants.ValueIndicatorCount)
            let view = JBarGraphIndicatorView(value: value)
            yContentView.addSubview(view)
            remakeYLevelViewLayout(view, index: index)
            yIndicatorViews.append(view)
            view.isHidden = true
        }
    }
    
    func showYIndicatorViews(_ show: Bool) {
        var index = 0.0
        for view in yIndicatorViews {
            view.animateShow(show, delay: index * 0.15)
            index += 1.0
        }
    }
    
    func remakeYLevelViewLayout(_ view: UIView, index: Int) {
        let min: CGFloat = 0
        let index = CGFloat(index)
        let count = CGFloat(Constants.ValueIndicatorCount)
        let value: CGFloat = (index / count)
        let multiplier = max(min, value)
        
        let container = yContentView
        let height = container.bounds.height
        let constant = height * multiplier
        let constraints = [
            view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: container.topAnchor, constant: constant),
            view.widthAnchor.constraint(equalTo: container.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // MARK: Y Levels
    
    func setupYLevelViews() {
        for levelView in yLevelViews {
            levelView.removeFromSuperview()
        }
        
        yLevelViews = [JBarGraphLevelView]()
        
        var index = 0.0
        for level in properties.levels {
            let view = JBarGraphLevelView(level: level, index: index)
            yLevelViews.append(view)
            addSubview(view)
            remakeYLevelLayout(view: view, level: level)
            view.animateOnLoad = true
            index += 1.0
        }
    }
    
    func remakeYLevelLayout(view: JBarGraphLevelView, level: JBarGraphLevel) {
        let topOffset = barCollectionView.frame.height
        - (barCollectionView.frame.height * (level.minValue / properties.maxValue))
        + Dimensions.TopPadding
        - (JBarGraphLevelView.Dimensions.Height / 2)
        
        let guide = yContentView
        let constraints = [
            view.topAnchor.constraint(equalTo: topAnchor, constant: topOffset),
            view.leftAnchor.constraint(equalTo: guide.leftAnchor),
            view.rightAnchor.constraint(equalTo: guide.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showYLevelViews(_ show: Bool) {
        var index = 0.0
        for view in yLevelViews {
            view.animateShow(show, delay: index * 0.15)
            index += 1.0
        }
    }
    
    // MARK: Setter
    
    func set(properties: JBarGraphProperties) {
        properties.updateItemLevels()
        properties.updateMaxValue()
        self.properties = properties
    }
}

extension JBarGraphView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case barCollectionView:
            guard let cell = cell as? JBarCollectionViewCell
            else {
                return
            }
            let item = properties.items[indexPath.row]
            let percentage = item.value / properties.maxValue
            let delay = 0.6 * percentage
            cell.setAnimatedBarPercentage(percentage, delay: delay)
            
        case itemCollectionView:
            return
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = properties.items[indexPath.row]
        switch collectionView {
        case barCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JBarCollectionViewCell.Identifier,
                                                                for: indexPath) as? JBarCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setBarHighlighted(indexPath.row == (properties.items.count - 1))
            cell.setLevel(item.level)
            cell.layoutIfNeeded()
            return cell
        case itemCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JBarItemCollectionViewCell.Identifier,
                                                                for: indexPath) as? JBarItemCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let isLast = indexPath.row == properties.items.count - 1
            cell.set(title: item.title, highlighted: isLast)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // TODO: Add JBarGraphControlView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showYLevelViews(!isShowingLevels)
        showYIndicatorViews(isShowingLevels)
        isShowingLevels = !isShowingLevels
    }
}

extension JBarGraphView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case barCollectionView, itemCollectionView:
            return properties.items.count
        default: return 0
        }
    }
}

extension JBarGraphView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cellWidth(from: collectionView)
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func cellWidth(from collectionView: UICollectionView) -> CGFloat {
        let spaces = CGFloat(properties.items.count) - 1.0
        return (collectionView.frame.width / CGFloat(properties.items.count)) - ((Dimensions.BarSpacing * spaces) / spaces)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Dimensions.BarSpacing
    }
}
