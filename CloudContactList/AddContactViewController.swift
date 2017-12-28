//
//  AddContactViewController.swift
//  CloudContactList
//
//  Created by Madushani Lekam Wasam Liyanage on 12/6/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var avatarUrlTextField: UITextField!
    
    let postAPI = "https://api.fieldbook.com/v1/5846e8bab2ee1a030035fa4a/contacts/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        var contactDictionary: [String:Any] = [:]
        
        if let name = nameTextField.text,
            let company = companyNameTextField.text,
            let role = roleTextField.text,
            let email = emailTextField.text,
            let avatarUrl = avatarUrlTextField.text {
            contactDictionary["name"] = name
            contactDictionary["company"] = company
            contactDictionary["role"] = role
            contactDictionary["email"] = email
            contactDictionary["avatarurl"] = avatarUrl
            
            APIRequestManager.manager.postRequest(from: postAPI, studentDict: contactDictionary)
            
            self.createAlert()
            self.clearAllTextFields()
            
        }
        
    }
    
    
    //http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    
    func createAlert() {
        let alert = UIAlertController(title: "Alert", message: "Cloud Contact Saved", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    //http://stackoverflow.com/questions/25097958/loop-through-subview-to-check-for-empty-uitextfield-swift
    
    func clearAllTextFields() {
        
        for view in self.view.subviews {
            if let textField = view as? UITextField {
                textField.text = ""
            }
        }

    }
    
    //http://stackoverflow.com/questions/34955987/pass-data-through-navigation-back-button
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ContactsTableViewController {
            controller.viewDidLoad()
            controller.tableView.reloadData()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     
     if segue.identifier == "reloadContactsSegue" {
     if let ctvc = segue.destination as? ContactsTableViewController {
     ctvc.viewDidLoad()
     ctvc.tableView.reloadData()
     }
     }
     
     
     }
     */
    
    
}
