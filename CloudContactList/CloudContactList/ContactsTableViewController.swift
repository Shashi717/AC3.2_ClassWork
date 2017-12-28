//
//  ContactsTableViewController.swift
//  CloudContactList
//
//  Created by Madushani Lekam Wasam Liyanage on 12/6/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    let getAPI = "https://api.fieldbook.com/v1/5846e8bab2ee1a030035fa4a/contacts/"
    
    
    let bodyDict: [String:Any] = [
        "name" : "Madushani",
        "company": "C4Q",
        "role": "Developer",
        "email": "me@gmail.com",
        "avatarurl": "https://fsdjfjds.com"
    ]
    
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getAllPosts(from: getAPI) { (data: Data?) in
            if  let validData = data,
                let validContacts = Contact.getContacts(from: validData) {
                self.contacts = validContacts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //  print(contacts.count)
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellIdentifier", for: indexPath)
        cell.imageView?.image = nil
        cell.textLabel?.text = contacts[indexPath.row].name
        let imageString = contacts[indexPath.row].avatarUrl
        
        if imageString != " " {
            APIRequestManager.manager.getData(endPoint: imageString ) { (data: Data?) in
                if  let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = validImage
                        cell.setNeedsLayout()
                        
                    }
                }
                
            }
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showContactDetailSegue" {
            if let acvc = segue.destination as? ContactDetailViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                acvc.contact = contacts[indexPath.row]
            }
        }
        
    }
 
}
