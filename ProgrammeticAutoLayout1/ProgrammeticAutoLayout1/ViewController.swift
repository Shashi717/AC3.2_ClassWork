//
//  ViewController.swift
//  ProgrammeticAutoLayout1
//
//  Created by Madushani Lekam Wasam Liyanage on 12/13/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let blueWidth = "H:[view]-(<=1.0)-[tobias(200.0)]"
        let blueHight = "V:[view]-(<=1.0)-[tobias(200.0)]"
        let views = ["tobias" : blueView,
                     "view" : self.view]
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        let blueWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: blueWidth, options: .alignAllCenterY, metrics: nil, views: views)
        
        let blueHeightConstraints = NSLayoutConstraint.constraints(withVisualFormat: blueHight, options: .alignAllCenterX, metrics: nil, views: views)
        
        
        NSLayoutConstraint.activate( blueHeightConstraints)
        NSLayoutConstraint.activate(blueWidthConstraints)
        
    }


}

