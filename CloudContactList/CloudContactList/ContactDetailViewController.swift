//
//  ContactDetailViewController.swift
//  CloudContactList
//
//  Created by Madushani Lekam Wasam Liyanage on 12/7/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let theContact = contact {
            nameLabel.text = theContact.name
            companyLabel.text = theContact.company
            roleLabel.text = theContact.role
            emailLabel.text = theContact.email
            let imageString = theContact.avatarUrl
            
            if imageString != " " {
                APIRequestManager.manager.getData(endPoint: imageString ) { (data: Data?) in
                    if  let validData = data,
                        let validImage = UIImage(data: validData) {
                        DispatchQueue.main.async {
                            self.contactImageView.image = validImage
                            
                        }
                    }
                    
                }
                
            }
            
        }
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
