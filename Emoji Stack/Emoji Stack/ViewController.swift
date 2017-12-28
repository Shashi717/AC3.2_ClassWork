//
//  ViewController.swift
//  Emoji Stack
//
//  Created by Madushani Lekam Wasam Liyanage on 12/22/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(cardView)
        self.cardView.translatesAutoresizingMaskIntoConstraints = false
        let cardViewConstraints =
            [cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
             cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
             cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
             cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0)
                ].map {$0.isActive = true }
        
        self.edgesForExtendedLayout = []
        
    }

   
    
   lazy var cardView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blue
//        view.showsVerticalScrollIndicator = true
//        view.showsHorizontalScrollIndicator = true
//        view.alwaysBounceHorizontal = true
//        view.alwaysBounceVertical = true
        return view
    }()
    
//    lazy var scrollView: UIScrollView = {
//        let view: UIScrollView = UIScrollView()
//        view.backgroundColor = .blue
//        view.showsVerticalScrollIndicator = true
//        view.showsHorizontalScrollIndicator = true
//        view.alwaysBounceHorizontal = true
//        view.alwaysBounceVertical = true
//        return view
//    }()
    

}

