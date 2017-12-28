//
//  GiphyTableViewController.swift
//  Giphy
//
//  Created by Madushani Lekam Wasam Liyanage on 10/26/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class GiphyTableViewController: UITableViewController {
    
    internal let GiphyTableViewCellIdentifier: String = "GiphyCellIdentifier"
    internal var giphys: [Giphy] = []
    internal let giphyEndpoint: String = "http://api.giphy.com/v1/gifs/search?q=dolphin&api_key=dc6zaTOxFJmzC"
    var selectedGiphy: Giphy?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GiphyFactory.makeGiphys(apiEndpoint: giphyEndpoint) { (returnedGiphys: [Giphy]?) in
            if let unwrappedReturnedGiphys = returnedGiphys {
                self.giphys = unwrappedReturnedGiphys
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }

 
    }

   
 

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return giphys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GiphyTableViewCellIdentifier, for: indexPath)
        
        
        cell.imageView?.image = nil
        cell.textLabel?.text = giphys[indexPath.row].slug
        cell.detailTextLabel?.text = giphys[indexPath.row].source
    
        let urlString = giphys[indexPath.row].giphyStillImageString
        
       // cell.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cell.imageView?.downloadImage(urlString: urlString)

        
        return cell
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedGiphy = self.giphys[indexPath.row]
        performSegue(withIdentifier: "GiphyDisplayIdentifier", sender: selectedGiphy)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GiphyDisplayIdentifier" {
            if let gdvc = segue.destination as? GiphyDetailViewController {
                gdvc.giphy = selectedGiphy
            }

        
        }
    }
 

}
