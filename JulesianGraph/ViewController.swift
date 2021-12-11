//
//  ViewController.swift
//  JulesianGraph
//
//  Created by Jules Gilos on 12/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var graphView = SampleGraphView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        remakeLayout()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(graphView)
        
        graphView.set(properties: TestDataHelper.properties())
    }
    
    func remakeLayout() {
        remakeGraphView()
    }
    
    func remakeGraphView() {
        let view = graphView
        let constraints = [
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
}

