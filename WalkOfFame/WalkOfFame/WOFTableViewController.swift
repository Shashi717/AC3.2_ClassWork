//
//  WOFTableViewController.swift
//  WalkOfFame
//
//  Created by Madushani Lekam Wasam Liyanage on 10/18/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class WOFTableViewController: UITableViewController {
    
    var walksOfFame = [Walk]()
    let walksJSONFileName: String = "walk_of_fame.json"
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let walksURL = URL.init(string: walksJSONFileName),let walkData = getData(from: walksURL), let walks = getWalks(from: walkData) {
//            for aWalk in walks {
//            walksOfFame.append(aWalk)
//            }
//        }

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return walksOfFame.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalkICelldentifier", for: indexPath)

        cell.textLabel?.text = walksOfFame[indexPath.row].designer

        return cell
    }
 
    
    internal func getWalks(from jsonData: Data) -> [Walk]? {
        
        
        // 1. This time around we'll add a do-catch
        do {
            let instaWalkJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            // 2. Cast from Any into a more suitable data structure and check for the "cats" key
            //convenience init?(withDict violationDict: [String:String]) {
            
            if let instaWalkDictionary = instaWalkJSONData as? [String: [String:[[Any]]]] {
                if let metaData = instaWalkDictionary["meta"], let walkData = metaData["data"] {
                    for walk in walkData {
                        if let designer = walk[8] as? String, let location = walk[10] as? String, let sketch = walk[11] as? String, let description = walk[9] as? String , let sketchURL = URL.init(string: sketch) {
                            
                            let data = Walk.init(designer: designer, location: location, description: description, sketchURL: sketchURL)
                            
                            self.walksOfFame.append(data)
                        }
                        
                    }
                    
                }
            }
            
            
            return walksOfFame
        }
        catch let error as NSError {
            // JSONSerialization doc specficially says an NSError is returned if JSONSerialization.jsonObject(with:options:) fails
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }

    
//    class func makeWalks(fileName: String) -> [Walk]? {
//        
//        // Everything from viewDidLoad in InstaCatTableViewController has just been moved here
//        guard let walksURL: URL = getResourceURL(from: fileName),
//            let walksData: Data = getData(from: walksURL),
//            let walksAll: [InstaCat] = getInstaCats(from: walksData) else {
//                return nil
//        }
//        
//        return walksAll
//    }
//    
    internal func getData(from url: URL) -> Data? {
        
        let fileData: Data? = try? Data(contentsOf: url)
        return fileData
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
