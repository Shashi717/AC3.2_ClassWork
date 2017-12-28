//
//  ViewController.swift
//  AC3.2-TrappedCats
//
//  Created by Madushani Lekam Wasam Liyanage on 11/3/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let instaCats: [InstaCat] = InstaCatFactory.makeInstaCats(fileName: "InstaCats.json") {
//            print("We've got cats \(instaCats)")
//           
//        let defaults = UserDefaults.standard
//            var defaultDict = [String: String]()
//            for eachCat in 0..<instaCats.count{
//                defaultDict["name \(eachCat)"] = instaCats[eachCat].name
//                defaultDict["id \(eachCat)"] = String(instaCats[eachCat].catID)
//                defaultDict["description \(eachCat)"] = instaCats[eachCat].description
//                defaultDict["instagram \(eachCat)"] = instaCats[eachCat].instagramURL.absoluteString
//                
//            }
//            
////          print(defaultDict)
//       defaults.set(defaultDict, forKey: "InstaCatsKey")
//           // defaults.set
////            if let cats = UserDefaults.standard.value(forKey: "InstaCats"){
////                dump(cats)
////            }
//        
//        }
        
        if let cats = UserDefaults.standard.value(forKey: "InstaCatsKey"){
                         dump(cats)
                    }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

